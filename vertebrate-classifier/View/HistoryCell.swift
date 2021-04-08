//
//  HistoryCell.swift
//  vertebrate-classifier
//
//  Created by Raj Kumar Shahu on 2021-03-27.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var classifiedByLabel: UILabel!
    
    @IBOutlet weak var classifiedAsLabel: UILabel!
    
    @IBOutlet weak var confidenceLabel: UILabel!
    
    @IBOutlet weak var classifiedOnLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configureCell(log: Log) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        let classifiedOnStr = "\(dateFormatter.string(from: NSDate() as Date))"
        
        classifiedByLabel.text = "Classified by: " + log.classifiedBy
        classifiedAsLabel.text = "Classified as: " + log.classifiedAs
        confidenceLabel.text = "Confidence: " + String(log.confidence) + " %"
        classifiedOnLabel.text = classifiedOnStr
    }
    

}
