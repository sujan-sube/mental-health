//
//  IndividualInsightsPageViewController.swift
//  OpenMind
//
//  Created by Shirshak Shrestha on 2017-03-27.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class IndividualInsightsPageViewController: UIViewController {
    
    var insight = Insights()

    @IBOutlet weak var insightTitleLabel: UILabel!
    @IBOutlet weak var insightsDetailTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        insightTitleLabel.text = insight?.insightsTopic
        insightsDetailTextView.text = insight?.insightsDetails
        insightsDetailTextView.isEditable = false
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
