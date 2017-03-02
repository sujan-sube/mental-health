//
//  HistoryTableViewCell.swift
//  testing2
//
//  Created by Rehan Anwar on 2017-02-28.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    //Mark: Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
