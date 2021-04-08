//
//  HistoryModel.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu on 2021-03-27.
//

import Foundation
import FirebaseFirestore

struct History {
    let classifiedBy: String
    let classifiedAs: String
    let confidence: Double
    let classifiedOn: Timestamp
    
//    init(data: [String: Any]) {
//        self.classifiedBy = data["classifiedBy"] as? String ?? ""
//        self.classifiedAs = data["classifiedAs"] as? String ?? ""
//        self.confidence = data["confidence"] as? Double ?? 0.0
//        self.classifiedOn = data["classifiedOn"] as? Timestamp ?? Timestamp()
//    }
    
    
}
