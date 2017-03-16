//
//  ViewController.swift
//  testing2
//
//  Created by Rehan Anwar on 2017-02-28.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit
import os.log
import CDAlertView


class AddJournalEntryViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    let data = EndPointTypes.Journal
    
    @IBOutlet weak var JournalTextView: UITextView!
    
    var JournalEntry : History?
    
    //Listen to notification with name of endpoint and call the catchNotification method once data is received from server
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        
    }
    
    //Stop listening to notifications. If not included, the catchNotification method will be run multiple times.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    //MARK: Navigation
    
    
    @IBAction func submitButton(_ sender: Any) {
        let httpbody = createHttpBody()
        APICommunication.apirequest(data: self.data, httpMethod: "POST", httpBody: httpbody)
        
    }
    
    func catchNotification(notification: Notification) -> Void {
        print("Caught Journal Submission notification")
        
        guard let jsonResponse = notification.userInfo else {
            print("No userInfo found in notification")
            return
        }
        
        //Success popup
        self.popup()
        
        //Convert data received to dictionary of [String:Any] to parse later
        let json = APICommunication.convertDatatoDictionary(data: jsonResponse["response"] as! Data)
        
        
        //Parse json response
        guard let id = json?["results"] as? [Any] else {
            print ("Could not find results element")
            return
        }
        
    }
    
    
    func createHttpBody() -> [String:Any] {
        
        let date = DateFormatting.getCurrentDate()
        let body = ["content":"\(self.JournalTextView.text)", "date":"\(date)"]
        
        return body
    }
    
    func popup() {
        
        let alert = CDAlertView(title: "Success!", message: "Journal Entry Submitted!", type: .success)
        //let action = CDAlertViewAction(title: "OK")
        alert.isTextFieldHidden = true
        //alert.add(action: action)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = .identity
            alpha = 0
        }
        alert.hideAnimationDuration = 0.1
        alert.show() { (alert) in
            print("completed")
        }
    }
    
    
}

