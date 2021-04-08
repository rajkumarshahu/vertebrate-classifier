//
//  LogsModel.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu on 2021-04-07.
//

import Foundation
import FirebaseFirestore

struct Log {
    var id: String
    var classifiedBy: String
    var classifiedAs: String
    var confidence: Double
    var classifiedOn: Timestamp
    
    init(id: String, classifiedBy: String, classifiedAs: String, confidence: Double, classifiedOn: Timestamp = Timestamp() ) {
        self.id = id
        self.classifiedBy = classifiedBy
        self.classifiedAs = classifiedAs
        self.confidence = confidence
        self.classifiedOn = classifiedOn
    }
    
    init(data: [String: Any]) {
                id = data["id"] as? String ?? ""
                classifiedBy = data["classifiedBy"] as? String ?? ""
                classifiedAs = data["classifiedAs"] as? String ?? ""
                confidence = data["confidence"] as? Double ?? 0.0
                classifiedOn = data["classifiedOn"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToData(log: Log) -> [String: Any] {
        
        let data : [String: Any] = [
            "id" : log.id,
            "classifiedBy" : log.classifiedBy,
            "classifiedAs" : log.classifiedAs,
            "confidence" : log.confidence,
            "classifiedOn" : log.classifiedOn
        
        ]
        return data
    }
}
