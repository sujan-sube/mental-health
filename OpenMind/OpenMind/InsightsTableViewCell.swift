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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        insightsMainView.layer.cornerRadius = 5
        insightsMainView.layer.masksToBounds = true
        insightsMainView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
