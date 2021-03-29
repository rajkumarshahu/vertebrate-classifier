//
//  LoginVC.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu and Supriya Gadkari 2021-03-25.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func forgotPassClicked(_ sender: Any) {
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text , email.isNotEmpty ,
            let password = passTxt.text , password.isNotEmpty else {
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                self.activityIndicator.stopAnimating()
                return
            }
            print("login was successfull")
            
            self.activityIndicator.stopAnimating()
            
            self.dismiss(animated: true, completion: nil)
            
            UIViewController().modalPresentationStyle = .fullScreen

        }
    }
    
    @IBAction func guestClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        UIViewController().modalPresentationStyle = .fullScreen
    }
}
