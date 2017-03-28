//
//  DashBoardViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-18.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import KDCircularProgress


class DashBoardViewController: UIViewController {
    
    let data = EndPointTypes.Profile
    var email : String?
        
    @IBOutlet weak var progress: KDCircularProgress!
    
//    let buttonBackgroundColor = UIColor(red: 131/255, green: 197/255, blue: 249/255, alpha: 0.95)
//    let buttonBackgroundColor = UIColor(red: 20/255, green: 97/255, blue: 160/255, alpha: 1)
    let buttonBackgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
    let buttonborderwidth = 0.5
    let buttonbordercolor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
    

    @IBOutlet weak var Journal: UIButton!
    @IBOutlet weak var Emotion: UIButton!
    @IBOutlet weak var Activity: UIButton!
    @IBOutlet weak var Sleep: UIButton!
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var progressShadowView: UIView!
    @IBOutlet weak var emotionShadowView: UIView!
    @IBOutlet weak var journalShadowView: UIView!
    @IBOutlet weak var activityShadowView: UIView!
    @IBOutlet weak var sleepShadowView: UIView!
    
    
    @IBOutlet weak var emotionButtonView: UIView!
    
    @IBOutlet weak var journalButtonView: UIView!
    @IBOutlet weak var activityButtonView: UIView!
    @IBOutlet weak var sleepButtonView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        self.setupJournalAnalysisProgressBar()
//        self.animateProgress(angle: 300)
        self.setupButtons()
//        self.progressView.layer.backgroundColor = UIColor(red: 131/255, green: 197/255, blue: 249/255, alpha: 1).cgColor
//        self.progressView.layer.backgroundColor = UIColor(red: 20/255, green: 97/255, blue: 160/255, alpha: 0.7).cgColor
        self.progressView.layer.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor

        self.progressView.layer.borderWidth = CGFloat(buttonborderwidth)
        self.progressView.layer.borderColor = buttonbordercolor.cgColor
        // Do any additional setup after loading the view.
        
        self.createShadows()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 177.0/255.0, green: 222.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor, UIColor(red: 75.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
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
        super.viewWillAppear(true)
        //self.animateProgress(angle: 300)
        self.navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        
        APICommunication.apirequest(data: self.data, httpMethod: "GET", httpBody: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        NotificationCenter.default.removeObserver(self)
        
    }

    @IBAction func Journal(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupButtons() -> Void {
        self.emotionButtonView.backgroundColor = buttonBackgroundColor
        self.journalButtonView.backgroundColor = buttonBackgroundColor
        self.activityButtonView.backgroundColor = buttonBackgroundColor
        self.sleepButtonView.backgroundColor = buttonBackgroundColor
        
        self.emotionButtonView.layer.borderWidth = CGFloat(buttonborderwidth)
        self.emotionButtonView.layer.borderColor = buttonbordercolor.cgColor
        
        self.journalButtonView.layer.borderWidth = CGFloat(buttonborderwidth)
        self.journalButtonView.layer.borderColor = buttonbordercolor.cgColor
        
        self.activityButtonView.layer.borderWidth = CGFloat(buttonborderwidth)
        self.activityButtonView.layer.borderColor = buttonbordercolor.cgColor
        
        self.sleepButtonView.layer.borderWidth = CGFloat(buttonborderwidth)
        self.sleepButtonView.layer.borderColor = buttonbordercolor.cgColor
        
        
//        let Journalimage = UIImage(named: "PositiveEntry")
//        let Emotionimage = UIImage(named: "PositiveEntry")
//        let Activityimage = UIImage(named: "PositiveEntry")
//        let Sleepimage = UIImage(named: "PositiveEntry")
//
        //self.Journal.imageEdgeInsets = UIEdgeInsetsMake(45, 45, 70, 45)
        //self.Journal.setImage(Journalimage, for: UIControlState.normal)
//        self.Journal.setTitle("Journal", for: UIControlState.normal)
//        self.Emotion.setTitle("Emotion", for: UIControlState.normal)
//        self.Activity.setTitle("Activity", for: UIControlState.normal)
//        self.Sleep.setTitle("Sleep", for: UIControlState.normal)
        
    }
    
    
    
    
    
    func setupJournalAnalysisProgressBar(color : UIColor) -> Void {
        
        progress.progressThickness = 0.1
        progress.trackThickness = 0.1
        progress.startAngle = -90
        progress.trackColor = UIColor.lightGray
        progress.clockwise = true
        //progress.gradientRotateSpeed = 5
        progress.roundedCorners = false
        progress.glowMode = .constant
        progress.glowAmount = 0.5
        progress.progressColors = [color]
        //progress.progressColors = [UIColor( ]
        
        
        return
    }
    
    func animateProgress(angle: Double) -> Void{
        
        progress.animate(fromAngle: 0, toAngle: angle, duration: 1.0) { completed in
            if completed {
//                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
        }
        return
    }
    
    func createShadows(){
        
        progressShadowView.layer.shadowPath = UIBezierPath(roundedRect: progressShadowView.layer.bounds, cornerRadius: 5).cgPath
                progressShadowView.layer.shouldRasterize = true
        progressShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        progressShadowView.layer.shouldRasterize = true
        progressShadowView.layer.cornerRadius = 5
        progressShadowView.layer.shadowColor = UIColor.black.cgColor
        progressShadowView.layer.shadowOpacity = 0.4
        progressShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        progressShadowView.layer.shadowRadius = 2.0
        
        emotionShadowView.layer.shadowPath = UIBezierPath(roundedRect: emotionShadowView.layer.bounds, cornerRadius: 5).cgPath
                emotionShadowView.layer.shouldRasterize = true
        emotionShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        emotionShadowView.layer.shouldRasterize = true
        emotionShadowView.layer.cornerRadius = 5
        emotionShadowView.layer.shadowColor = UIColor.black.cgColor
        emotionShadowView.layer.shadowOpacity = 0.4
        emotionShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        emotionShadowView.layer.shadowRadius = 2.0
        
        journalShadowView.layer.shadowPath = UIBezierPath(roundedRect: journalShadowView.layer.bounds, cornerRadius: 5).cgPath
                journalShadowView.layer.shouldRasterize = true
        journalShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        journalShadowView.layer.shouldRasterize = true
        journalShadowView.layer.cornerRadius = 5
        journalShadowView.layer.shadowColor = UIColor.black.cgColor
        journalShadowView.layer.shadowOpacity = 0.4
        journalShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        journalShadowView.layer.shadowRadius = 2.0
        
        activityShadowView.layer.shadowPath = UIBezierPath(roundedRect: activityShadowView.layer.bounds, cornerRadius: 5).cgPath
                activityShadowView.layer.shouldRasterize = true
        activityShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        activityShadowView.layer.shouldRasterize = true
        activityShadowView.layer.cornerRadius = 5
        activityShadowView.layer.shadowColor = UIColor.black.cgColor
        activityShadowView.layer.shadowOpacity = 0.4
        activityShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        activityShadowView.layer.shadowRadius = 2.0
        
        sleepShadowView.layer.shadowPath = UIBezierPath(roundedRect: sleepShadowView.layer.bounds, cornerRadius: 5).cgPath
                sleepShadowView.layer.shouldRasterize = true
        sleepShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        sleepShadowView.layer.shouldRasterize = true
        sleepShadowView.layer.cornerRadius = 5
        sleepShadowView.layer.shadowColor = UIColor.black.cgColor
        sleepShadowView.layer.shadowOpacity = 0.4
        sleepShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        sleepShadowView.layer.shadowRadius = 2.0
        
    }
    
    
    func catchNotification(notification: Notification) -> Void {
        print("Caught Graph notification")
        
        guard let jsonResponse = notification.userInfo else {
            print("No userInfo found in notification")
            return
        }
        
        //Convert data received to dictionary of [String:Any] to parse later
        let json = APICommunication.convertDatatoDictionary(data: jsonResponse["response"] as! Data)
        
        
        //Parse json response
        guard let profile = json?["email"] as? String else {
            print ("Could not find email element")
            self.email = "openmindhealth@gmail.com"
            updateprogress()
            return
        }
        
        self.email = profile
        
        updateprogress()
        
        //Print json elements in label
        
    }

    
    func updateprogress() -> Void {
        
        if (self.email == "openmindhealth@gmail.com") {
            
            self.setupJournalAnalysisProgressBar(color: UIColor.green)
            self.animateProgress(angle: 300)
        }
        else if self.email == "openmindhealthn@gmail.com"{
            
            self.setupJournalAnalysisProgressBar(color: UIColor.blue)
            self.animateProgress(angle: 100)
        }
        else
        {
            self.setupJournalAnalysisProgressBar(color: UIColor.orange)
            self.animateProgress(angle: 200)
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

