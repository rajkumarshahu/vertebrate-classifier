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
        // Initialization code
    }

    func configureCell(history: History) {
        classifiedByLabel.text = "Classified by: " + history.classifiedBy
        classifiedAsLabel.text = "Classified as: " + history.classifiedAs
        confidenceLabel.text = "Confidence: " + String(history.confidence) + " %"
        classifiedOnLabel.text = "Classified on: " + history.classifiedOn
    }
    

}
