//
//  InsideDayTableViewCell.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-29.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit

class InsideDayTableViewCell: UITableViewCell {

    @IBOutlet weak var labelExerciseName: UILabel!
    @IBOutlet weak var labelSet1: UILabel!
    @IBOutlet weak var labelSet2: UILabel!
    @IBOutlet weak var labelSet3: UILabel!
    @IBOutlet weak var labelSet4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
