//
//  ViewControllerTableViewCell.swift
//  PowerPal
//
//  Created by Avery Speller on 2018-03-23.
//  Copyright © 2018 Avery Speller. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelBench: UILabel!
    @IBOutlet weak var labelSquat: UILabel!
    @IBOutlet weak var labelDL: UILabel!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelWilks: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
