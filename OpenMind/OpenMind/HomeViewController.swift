//
//  HomeViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-01-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Testing
        let physical:PhysicalActivityManager = PhysicalActivityManager()
        physical.authorizeHealthKit { (authorized, error) in
            if authorized {
                
                // Add code for authorization
                //self.setHeight()
            } else {
                if error != nil {
                    //print(error)
                }
                print("Permission denied.")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
