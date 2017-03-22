//
//  Insights.swift
//  OpenMind
//
//  Created by Shirshak Shrestha on 2017-03-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import Foundation

class Insights {
    
    var insightsTopic: String
    var insightsInfo: String
    var photo: UIImage
    
    init?(insightsTopic: String, insightsInfo:String, photo: UIImage) {
        
        //Initialization should fail if there is insights topic
        
        if insightsTopic.isEmpty {
            return nil
        }
        
        self.insightsTopic = insightsTopic
        self.insightsInfo = insightsInfo
        self.photo = photo
    }
}
