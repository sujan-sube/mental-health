//
//  testViewController.swift
//  apiconnection2
//
//  Created by Rehan Anwar on 2017-03-12.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit


class testViewController: UIViewController {

    //Declare type of endpoint to hit
    let data = EndPointTypes.Journal
    @IBOutlet weak var textview: UITextView!
    
    
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
    
    @IBAction func button(_ sender: Any) {
        
        //Send request to server
        APICommunication.apirequest(data: self.data, httpMethod: "GET", httpBody: nil)
        
    }

    //Method called once data is received from the server
    
    func catchNotification(notification: Notification) -> Void {
        print("Caught Graph notification")
        
        guard let jsonResponse = notification.userInfo else {
            print("No userInfo found in notification")
            return
        }
            
        //Convert data received to dictionary of [String:Any] to parse later
        let json = APICommunication.convertDatatoDictionary(data: jsonResponse["response"] as! Data)
        
        
        //Parse json response
        guard let id = json?["results"] as? [Any] else {
            print ("Could not find results element")
            return
        }
        
        guard let user = id.first as? [String: Any],
            let content = user["content"] as? String,
            let date = user["date"] as? String else {
                print ("key-value pairs do not match JSON response")
                return
        }
        //Print json elements in label
        self.textview.text = ("the content is \(content) and the date is " + date)
        
    }

}
