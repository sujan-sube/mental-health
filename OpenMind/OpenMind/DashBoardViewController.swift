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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupJournalAnalysisProgressBar()
        self.animateProgress(angle: 300)
        self.setupButtons()
        //self.progressView.layer.backgroundColor = UIColor(red: 131/255, green: 197/255, blue: 249/255, alpha: 1).cgColor
        self.progressView.layer.backgroundColor = UIColor(red: 131/255, green: 197/255, blue: 253/255, alpha: 1).cgColor
        self.progressView.layer.borderWidth = CGFloat(buttonborderwidth)
        self.progressView.layer.borderColor = buttonbordercolor.cgColor
        // Do any additional setup after loading the view.
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
        self.Journal.backgroundColor = buttonBackgroundColor
        self.Emotion.backgroundColor = buttonBackgroundColor
        self.Activity.backgroundColor = buttonBackgroundColor
        self.Sleep.backgroundColor = buttonBackgroundColor
        
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

    
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

