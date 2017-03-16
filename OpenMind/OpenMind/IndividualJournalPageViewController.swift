//
//  IndividualJournalPageViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-16.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class IndividualJournalPageViewController: UIViewController {

    var date : String?
    var time : String?

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var JournalEntryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DateLabel.text = "\(self.date) at  \(self.time)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
