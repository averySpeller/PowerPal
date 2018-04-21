//
//  DayTableViewCell.swift
//  
//
//  Created by Avery Speller on 2018-03-28.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
