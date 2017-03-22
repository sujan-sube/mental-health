//
//  AppDelegate.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-01-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    // [START didfinishlaunching]
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        
        GIDSignIn.sharedInstance().clientID = "244090642066-03iqlpq54om9u4da4hu6gfkbno10pqlb.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().serverClientID = "244090642066-789ii5nf638o81ojcslbqflgqobn114p.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
//        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 20.0)!, NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor(red: 20.0/255.0, green: 97.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        UIApplication.shared.statusBarStyle = .default
        
//        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(red: 20.0/255.0, green: 97.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//        UITabBar.appearance() = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        
        return true
    }
    // [END didfinishlaunching]
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    // [START signin_handler]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let serverAuthCode = user.serverAuthCode
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
           
            // [START_EXCLUDE]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
            
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SignIn_Google"), object: nil)

            
            window?.becomeKey()
            // [END_EXCLUDE]
            
            
            // Once signed in redirect to Home Page
            
            
            let homeViewController:UITabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            
            
            
            homeViewController.selectedIndex = 0
            window?.rootViewController = homeViewController
            
//            let server = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/rest-auth/google/"
            let server = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/journal/"
            
//            RESTCommunication.getToken(server, serverAuthCode!)
            
            GIDSignIn.sharedInstance().signOut()
//            print(serverAuthCode)
            
//            let alert = UIAlertController(title: "Alert", message: idToken, preferredStyle: UIAlertControllerStyle.alert)
//            
//            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
//            window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
    }
    // [END signin_handler]
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
    // [END disconnect_handler]
}
