//
//  InsightsTableViewCell.swift
//  apiconnection2
//
//  Created by Shirshak Shrestha on 2017-03-18.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class InsightsTableViewCell: UITableViewCell {

    @IBOutlet weak var insightsImage: UIImageView!
    @IBOutlet weak var insightsTopic: UILabel!
    @IBOutlet weak var insightsDetails: UILabel!
    @IBAction func dismissoOnClick(_ sender: UIButton) {
    }
    @IBOutlet weak var insightsMainView: UIView!
    @IBOutlet weak var insightsDismissView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        insightsMainView.layer.cornerRadius = 5
        insightsMainView.layer.masksToBounds = true
        insightsMainView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        insightsDismissView.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 100/255.0, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
