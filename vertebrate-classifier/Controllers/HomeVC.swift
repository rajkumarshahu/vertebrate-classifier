//
//  ViewController.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu and Supriya Gadkari on 2021-03-24.
//

import UIKit
import Firebase
import CoreML
import Vision

class HomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var classificationLabel: UILabel!
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: VertebrateClassifier().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                self.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Core ML Model: \(error)")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if  (Auth.auth().currentUser != nil)  {
            loginOutBtn.title = "Logout"
        } else {
            loginOutBtn.title = "Login"
        }
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginVC")
        UIViewController().modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func loginOutClicked(_ sender: Any) {
        
        if  (Auth.auth().currentUser != nil) {
            do {
                try Auth.auth().signOut()
                presentLoginController()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        } else {
            presentLoginController()
        }
    }
    
    
    @IBAction func cameraBtnClicked(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        let photoSourcePicker = UIAlertController()
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
            self.presentPhotoPicker(sourceType: .camera)
            
        }
        
        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default) { _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        
        photoSourcePicker.addAction(takePhotoAction)
        photoSourcePicker.addAction(choosePhotoAction)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(photoSourcePicker, animated: true, completion: nil)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageView.image = image
        updateClassifications(for: image)
        
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        guard let classifications = request.results as? [VNClassificationObservation] else {
            self.classificationLabel.text = "Unable to classify image.\n\(error?.localizedDescription ?? "Error")"
            return
        }
        
        if classifications.isEmpty {
            self.classificationLabel.text = "Nothing recognized.\nPlease try again."
        } else {
            let topClassifications = classifications.prefix(2)
            let descriptions = topClassifications.map { classification in
                return classification.identifier + " with " + String(format: "%.2f", classification.confidence * 100) + "% Confidence"
            }
            
            self.classificationLabel.text = "The vertebrate on image is classified as:\n" + descriptions.joined(separator: "\n")
        }
    }
    
    func updateClassifications(for image: UIImage) {
        classificationLabel.text = "Classifying..."
        
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)),
            let ciImage = CIImage(image: image) else {
            print("Something went wrong...\nPlease try again.")
            return
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
        do {
            try handler.perform([classificationRequest])
        } catch {
            print("Failed to perform classification: \(error.localizedDescription)")
        }
    }
    
}

