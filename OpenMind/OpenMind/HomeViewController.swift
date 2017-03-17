//
//  HomeViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-01-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

class HomeViewController: UIViewController {

    
    var userInfo: GIDGoogleUser = GIDGoogleUser()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
//        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.userLogin(_:)), name: NSNotification.Name(rawValue: "signIn_Google"), object: nil)
//        print(self.userInfo.userID)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    deinit {
        //NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func userLogin(_ notification: NSNotification) {
        if notification.name.rawValue == "signIn_Google" {
            //self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else { return }
                //self.statusText.text = userInfo["statusText"]!
            }
        }
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
