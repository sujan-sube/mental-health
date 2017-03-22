//
//  EmotionAddViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import os.log
import CDAlertView
import SpringIndicator

class EmotionAddViewController: UIViewController {

    @IBOutlet weak var LoadingIndicator: SpringIndicator!
    let data = EndPointTypes.Journal
    
    @IBOutlet weak var JournalTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitButton(_ sender: Any) {
//        let httpbody = createHttpBody()
//        LoadingIndicator.lineColor=UIColor.lightGray
//        LoadingIndicator.lineWidth=CGFloat(2.0)
//        LoadingIndicator.startAnimation()
//        APICommunication.apirequest(data: self.data, httpMethod: "POST", httpBody: httpbody)
        
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
