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

    var date : String?
    var time : String?
    
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var JournalFeedbackLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var JournalEntryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DateLabel.text = "\(self.date) at  \(self.time)"
        
        self.setupJournalAnalysisProgressBar()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
