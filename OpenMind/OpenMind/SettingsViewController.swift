//
//  SettingsViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-01-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var SignOut: UIButton!
    
    @IBAction func signoutButtonOnClick(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
        let signInViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInController") 
        
        //        self.navigationController?.show(homeViewController, sender: nil)
//        homeViewController.selectedIndex = 0
        self.view.window?.rootViewController = signInViewController
        
        
    }
    @IBOutlet weak var textview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.textview.layer.cornerRadius = 15.0
        self.SignOut.layer.cornerRadius = 10
        self.SignOut.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 100/255.0, alpha: 1).cgColor
        
        //SET BACKGROUNG BLUE GRADIENT
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 177.0/255.0, green: 222.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor, UIColor(red: 75.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
   
        
        // Do any additional setup after loading the view.
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
