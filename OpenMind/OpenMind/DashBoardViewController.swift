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
        
    @IBOutlet weak var progress: KDCircularProgress!
    
    let buttonBackgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupJournalAnalysisProgressBar()
        self.animateProgress(angle: 300)
        self.setupButtons()
        self.progressView.layer.backgroundColor = UIColor(red: 131/255, green: 197/255, blue: 249/255, alpha: 1).cgColor
//        self.progressView.layer.backgroundColor = UIColor(red: 131/255, green: 197/255, blue: 253/255, alpha: 1).cgColor
        self.progressView.layer.borderWidth = CGFloat(buttonborderwidth)
        self.progressView.layer.borderColor = buttonbordercolor.cgColor
        // Do any additional setup after loading the view.
        
        self.createShadows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.animateProgress(angle: 300)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
        
    }

    @IBAction func Journal(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupButtons() -> Void {
//        self.Journal.backgroundColor = buttonBackgroundColor
//        self.Emotion.backgroundColor = buttonBackgroundColor
//        self.Activity.backgroundColor = buttonBackgroundColor
//        self.Sleep.backgroundColor = buttonBackgroundColor
        
        self.Journal.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Journal.layer.borderColor = buttonbordercolor.cgColor
        
        self.Emotion.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Emotion.layer.borderColor = buttonbordercolor.cgColor
        
        self.Activity.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Activity.layer.borderColor = buttonbordercolor.cgColor
        
        self.Sleep.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Sleep.layer.borderColor = buttonbordercolor.cgColor
        
        
        let Journalimage = UIImage(named: "PositiveEntry")
        let Emotionimage = UIImage(named: "PositiveEntry")
        let Activityimage = UIImage(named: "PositiveEntry")
        let Sleepimage = UIImage(named: "PositiveEntry")
        
        //self.Journal.imageEdgeInsets = UIEdgeInsetsMake(45, 45, 70, 45)
        //self.Journal.setImage(Journalimage, for: UIControlState.normal)
        self.Journal.setTitle("Journal", for: UIControlState.normal)
        self.Emotion.setTitle("Emotion", for: UIControlState.normal)
        self.Activity.setTitle("Activity", for: UIControlState.normal)
        self.Sleep.setTitle("Sleep", for: UIControlState.normal)
        
    }
    
    
    
    
    
    func setupJournalAnalysisProgressBar() -> Void {
        
        progress.progressThickness = 0.1
        progress.trackThickness = 0.1
        progress.startAngle = -90
        progress.trackColor = UIColor.lightGray
        progress.clockwise = true
        //progress.gradientRotateSpeed = 5
        progress.roundedCorners = false
        progress.glowMode = .constant
        progress.glowAmount = 0.5
        progress.progressColors = [UIColor.green, UIColor.white]
        progress.progressColors = [UIColor(red: 1, green: 1, blue: 1, alpha: 0.8) ]
        
        
        return
    }
    
    func animateProgress(angle: Double) -> Void{
        
        progress.animate(fromAngle: 0, toAngle: angle, duration: 1.0) { completed in
            if completed {
                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
        }
        return
    }
    
    func createShadows(){
        
        progressShadowView.layer.shadowPath = UIBezierPath(roundedRect: progressShadowView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        progressShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        progressShadowView.layer.shouldRasterize = true
        progressShadowView.layer.cornerRadius = 5
        progressShadowView.layer.shadowColor = UIColor.black.cgColor
        progressShadowView.layer.shadowOpacity = 0.4
        progressShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        progressShadowView.layer.shadowRadius = 2.0
        
        emotionShadowView.layer.shadowPath = UIBezierPath(roundedRect: emotionShadowView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        emotionShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        emotionShadowView.layer.shouldRasterize = true
        emotionShadowView.layer.cornerRadius = 5
        emotionShadowView.layer.shadowColor = UIColor.black.cgColor
        emotionShadowView.layer.shadowOpacity = 0.4
        emotionShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        emotionShadowView.layer.shadowRadius = 2.0
        
        journalShadowView.layer.shadowPath = UIBezierPath(roundedRect: journalShadowView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        journalShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        journalShadowView.layer.shouldRasterize = true
        journalShadowView.layer.cornerRadius = 5
        journalShadowView.layer.shadowColor = UIColor.black.cgColor
        journalShadowView.layer.shadowOpacity = 0.4
        journalShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        journalShadowView.layer.shadowRadius = 2.0
        
        activityShadowView.layer.shadowPath = UIBezierPath(roundedRect: activityShadowView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        activityShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        activityShadowView.layer.shouldRasterize = true
        activityShadowView.layer.cornerRadius = 5
        activityShadowView.layer.shadowColor = UIColor.black.cgColor
        activityShadowView.layer.shadowOpacity = 0.4
        activityShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        activityShadowView.layer.shadowRadius = 2.0
        
        sleepShadowView.layer.shadowPath = UIBezierPath(roundedRect: sleepShadowView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        sleepShadowView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        sleepShadowView.layer.shouldRasterize = true
        sleepShadowView.layer.cornerRadius = 5
        sleepShadowView.layer.shadowColor = UIColor.black.cgColor
        sleepShadowView.layer.shadowOpacity = 0.4
        sleepShadowView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        sleepShadowView.layer.shadowRadius = 2.0
        
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

