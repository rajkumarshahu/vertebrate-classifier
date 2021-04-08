//
//  LogDateSet.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu on 2021-04-08.
//

import Foundation
import FirebaseFirestore

class LogDataSet {
    
    let logs = [
        Log(id: "111111111", classifiedBy: "Raj", classifiedAs: "Mammal", confidence: 99.99, classifiedOn: Timestamp()),
        Log(id: "111111111", classifiedBy: "Supriya", classifiedAs: "Bird", confidence: 95.23, classifiedOn: Timestamp()),
        Log(id: "111111111", classifiedBy: "John", classifiedAs: "Reptile", confidence: 91.56, classifiedOn: Timestamp()),
        Log(id: "111111111", classifiedBy: "Kelvin", classifiedAs: "Fish", confidence: 81.99, classifiedOn: Timestamp()),
        Log(id: "111111111", classifiedBy: "Harry", classifiedAs: "Amphibian", confidence: 80.26, classifiedOn: Timestamp()),
        Log(id: "111111111", classifiedBy: "Salman", classifiedAs: "Fish", confidence: 84.23, classifiedOn: Timestamp()),
        Log(id: "111111111", classifiedBy: "Jane", classifiedAs: "Amphibian", confidence: 84.23, classifiedOn: Timestamp())

    ]
    
    func getLogs() -> [Log] {
        return logs
    }
}
