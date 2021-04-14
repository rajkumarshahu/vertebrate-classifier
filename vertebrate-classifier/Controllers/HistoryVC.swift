//
//  HistoryVC.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu and Supriya Gadkari on 2021-03-27.
//  @Description:

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refDb: DatabaseReference!
    
    var taskCount: Int? = 0
    
    var allTodos = [LogsModel]()
    var todo:LogsModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    //    var logs = [Log]()
    var listener: ListenerRegistration!
    var db : Firestore!
    var user = User()
    
    //   let data = LogDataSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refDb = Database.database().reference()
        
        if UserService.userListener == nil {
            UserService.getCurrentUser()
        }
        print(user)
        
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        //        setupQuery()
        
        getDataFromFirebase()
    }
    
    func getDataFromFirebase(){
        refDb.child("users").observe(DataEventType.value, with: { (snapshot) in
            if let postDict = snapshot.value as? Dictionary<String, AnyObject> {
                
                //self.allTodos = [LogsModel]()
                for item in postDict {
                    //print(item)
                    let myTodo = LogsModel(key:"", todo: item.value as! NSDictionary)
                    print(item)
                    self.allTodos.append(myTodo)
                    //print(self.allTodos[0].classifiedDate)
                    
                }
                print(postDict.count)
                self.taskCount = Int(postDict.count)
                self.tableView.reloadData()
                
            }
        })
    }
    
    func setupQuery() {
        
        var ref: Query!
        
        ref = db.collection("users").document(UserService.user.id).collection("logs")
        
        listener = ref.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let user = User.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, user: user)
                case .modified:
                    print("modified")
                //                    self.onDocumentModified(change: change, user: user)
                case .removed:
                    print("removed")
                //                    self.onDocumentRemoved(change: change)
                }
            })
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return data.logs.count
        
        return  self.taskCount!
        
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        if let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryCell {
    //            cell.configureCell(log: data.logs[indexPath.row])
    //            return cell
    //        }
    //        return UITableViewCell()
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryCell)!
        
        todo = allTodos[indexPath.row]
        print("Supriya: \(allTodos[indexPath.row])")
        print("Supriya: \(todo.classifierName)")
        
        cell.classifiedByLabel?.text = "Classified By: "+todo.classifierName
        cell.classifiedAsLabel?.text = todo.classifiedDescription
        cell.confidenceLabel?.text = todo.classifiedDate
        
        //cell.delegate = self 123456
        return cell        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func onDocumentAdded(change: DocumentChange, user: User) {
        let newIndex = Int(change.newIndex)
        users.insert(user, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
    }
}
