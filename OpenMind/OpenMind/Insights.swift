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
    var insightsDetails: String
    var photo: UIImage?
    
    
    init? (){
        self.insightsDetails = ""
        self.insightsTopic = ""
        self.insightsInfo = ""
    }
    
    init?(insightsTopic: String, insightsInfo:String, photo: UIImage, detail: String = "") {
        
        //Initialization should fail if there is insights topic
        
        if insightsTopic.isEmpty {
            return nil
        }
        self.insightsDetails = detail
        self.insightsTopic = insightsTopic
        self.insightsInfo = insightsInfo
        self.photo = photo
    }
}
