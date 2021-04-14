//
//  LogsModel.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu on 2021-04-07.
//

import Foundation
class LogsModel: NSObject {
    
    // var id: String
    var classifierName: String
    var classifiedDate: String
    var classifiedDescription : String
    //var classifiedOn: Timestamp
    
    init(classifierName: String, classifiedDate: String, classifiedDescription: String ) {
        // self.id = id
        self.classifierName = classifierName
        self.classifiedDate = classifiedDate
        self.classifiedDescription = classifiedDescription
        //self.classifiedOn = classifiedOn
    }
    
    init(key : String, todo: NSDictionary) {
        //  id = data["id"] as? String ?? ""
        classifierName = todo["classifierName"] as? String ?? ""
        classifiedDate = todo["classifiedDate"] as? String ?? ""
        classifiedDescription = todo["classifiedDescription"] as? String ?? ""
        // classifiedOn = data["classifiedOn"] as? Timestamp ?? Timestamp()
    }
    
    convenience override init() {
        self.init(classifierName: "", classifiedDate: "", classifiedDescription: "" )
    }
}
