//
//  IndividualJournalPageViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-16.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import KDCircularProgress

class IndividualJournalPageViewController: UIViewController {

    let data = EndPointTypes.Journal
    var date : String?
    var time : String?
    var DatabaseDate : String?
    
    var journalEntry : String?
    var analysis: Int?
    var analysis_comment: String?
    
    
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var JournalFeedbackLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var JournalEntryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DateLabel.text = "\(self.date!) at  \(self.time!)"
        
        self.setupJournalAnalysisProgressBar()

        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        
        APICommunication.apirequest(data: self.data, httpMethod: "GET", httpBody: nil)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func setupJournalAnalysisProgressBar() -> Void {
        
        progress.progressThickness = 0.4
        progress.trackThickness = 0.6
        progress.startAngle = -90
        progress.trackColor = UIColor.lightGray
        progress.clockwise = true
        //progress.gradientRotateSpeed = 5
        progress.roundedCorners = false
        progress.glowMode = .constant
        progress.glowAmount = 0.5
        progress.progressColors = [UIColor.green, UIColor.white]
        
        progress.animate(fromAngle: 0, toAngle: 360, duration: 4.0) { completed in
            if completed {
                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
            self.JournalFeedbackLabel.text = "Happy Entry! Good day today"
        }
        
        return
    }
    
    
    
    func catchNotification(notification: Notification) -> Void {
        print("Caught individual journal entry notification")
        
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
        
        for index in 0..<id.count
        {
            guard let user = id[index] as? [String: Any],
                let content = user["content"] as? String,
                let analysis = user["analysis"] as? String,
                let analysis_comment = user["analysis_comment"] as? String
            else {
                    print ("key-value pairs do not match JSON response")
                    return
            }
             self.journalEntry = content
            
        }
        
       
        
        self.updatePage()
        
        //Print json elements in label
        
    }
    
    
    
    func updatePage() -> Void {
        self.JournalEntryTextView.text = self.journalEntry
        
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
