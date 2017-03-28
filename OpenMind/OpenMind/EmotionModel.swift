//
//  EmotionModel.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-27.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class EmotionModel {
    //Mark: Properties
    
    var date: String
    var time: String
    var photo: UIImage
    var DatabaseDate:String
    var imageurl: String
    var expressions :[String:Any]
    
    //Mark: Initialization
    
    init?(date: String, time:String, photo: UIImage, DatabaseDate: String, imageurl: String, expressions: [String:Any]) {
        
        //Initialization should fail if there is no date
        
        if date.isEmpty {
            return nil
        }
        
        self.date = date
        self.time = time
        self.photo = photo
        self.DatabaseDate = DatabaseDate
        self.imageurl = imageurl
        self.expressions = expressions
        
    }
    
}
