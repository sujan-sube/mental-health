//
//  TodayTableViewCell.swift
//  OpenMind
//
//  Created by Shirshak Shrestha on 2017-03-16.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    //Mark: Properties
    
    
    @IBOutlet weak var typeImageView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
