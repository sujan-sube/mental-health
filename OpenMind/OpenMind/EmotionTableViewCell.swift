//
//  EmotionTableViewCell.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-27.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class EmotionTableViewCell: UITableViewCell {

    
    
    //Mark: Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeeLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    var DatabaseDate : String?
    var imageurl : String?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
