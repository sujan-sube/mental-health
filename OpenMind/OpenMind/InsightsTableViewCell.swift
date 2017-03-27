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

    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        insightsMainView.layer.cornerRadius = 5
        insightsMainView.layer.masksToBounds = true
        insightsMainView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
//        insightsDismissView.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 100/255.0, alpha: 1).cgColor
        insightsMainView.isUserInteractionEnabled = false
        insightsImage.isUserInteractionEnabled = false
        insightsTopic.isUserInteractionEnabled = false
        insightsDetails.isUserInteractionEnabled = false
//        let size = insightsMainView.bounds.size
//        let width = insightsMainView.bounds.width
//        let height = insightsMainView.bounds.height
//        
//        var ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
//        var path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
        
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: insightsMainView.layer.bounds, cornerRadius: 5).cgPath
//        insightsMainView.layer.shouldRasterize = true
        shadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        shadowView.layer.shouldRasterize = true
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        shadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        shadowView.layer.shadowRadius = 2.0
        shadowView.isUserInteractionEnabled = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
