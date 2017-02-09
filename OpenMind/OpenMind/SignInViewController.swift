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
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignInViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)
        let signInButton = GIDSignInButton(frame: CGRect(x: 20, y: 0, width: 200, height: 21))
        self.view.addSubview(signInButton)
        
        
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
