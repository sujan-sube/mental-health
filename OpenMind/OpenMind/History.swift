//
//  History.swift
//  testing2
//
//  Created by Rehan Anwar on 2017-02-28.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class History {
    //Mark: Properties
    
    var date: String
    var time: String
    var photo: UIImage
    
    //Mark: Initialization
    
    init?(date: String, time:String, photo: UIImage) {
        
        //Initialization should fail if there is no date
        
        if date.isEmpty {
            return nil
        }
    
        self.date = date
        self.time = time
        self.photo = photo
        
        
    }
    
}


