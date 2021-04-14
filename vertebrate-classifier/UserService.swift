//
//  UserService.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu on 2021-04-07.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
 
    var user = User()
//    var logs = [Log]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListener : ListenerRegistration? = nil
    var logListener : ListenerRegistration? = nil
    
   
    
    func getCurrentUser() {
        guard let authUser = auth.currentUser else { return }
        
        let userRef = db.collection("users").document(authUser.uid)
        userListener = userRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return }
            self.user = User.init(data: data)
            
            print(self.user)
        })
        
        let logRef = userRef.collection("logs")
        logListener = logRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documents.forEach({ (document) in
//                let log = Log.init(data: document.data())
//                self.logs.append(log)
            })
        })
    }
}
