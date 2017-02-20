//
//  signInViewController.swift
//  OpenMind
//
//  Created by Shirshak Shrestha on 2017-02-08.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    // [START viewcontroller_vars]
    @IBOutlet weak var signInButton: GIDSignInButton!
    //@IBOutlet weak var signOutButton: UIButton!
    //@IBOutlet weak var disconnectButton: UIButton!
    //@IBOutlet weak var statusText: UILabel!
    // [END viewcontroller_vars]
    // [START viewdidload]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sign In UI
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 20.0/255.0, green: 97.0/255.0, blue: 160.0/255.0, alpha: 1.0).cgColor, UIColor(red: 45.0/255.0, green: 154.0/255.0, blue: 206.0/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let signInButton = GIDSignInButton(frame: CGRect(x: screenWidth/2 - 100, y: screenHeight/2 - 12, width: 200, height: 21))
        
        self.view.addSubview(signInButton)
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignInViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)
        
        
        
        
        
        
        
        
        //statusText.text = "Initialized Swift app..."
        //toggleAuthUI()
        // [END_EXCLUDE]
    }
    // [END viewdidload]
    // [START signout_tapped]
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        // [START_EXCLUDE silent]
        //statusText.text = "Signed out."
        //toggleAuthUI()
        // [END_EXCLUDE]
    }
    // [END signout_tapped]
    // [START disconnect_tapped]
    /*@IBAction func didTapDisconnect(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().disconnect()
        // [START_EXCLUDE silent]
        statusText.text = "Disconnecting."
        // [END_EXCLUDE]
    }
    // [END disconnect_tapped]
    // [START toggle_auth]
    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            signInButton.isHidden = true
            signOutButton.isHidden = false
            disconnectButton.isHidden = false
        } else {
            signInButton.isHidden = false
            signOutButton.isHidden = true
            disconnectButton.isHidden = true
            statusText.text = "Google Sign in\niOS Demo"
        }
    }
    // [END toggle_auth]
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                                  object: nil)
    }*/
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            //self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else { return }
                //self.statusText.text = userInfo["statusText"]!
            }
        }
    }
 }
