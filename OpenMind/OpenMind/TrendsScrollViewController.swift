//
//  TrendsScrollViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-03-20.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class TrendsScrollViewController: UIViewController {

    @IBOutlet weak var TrendScroll: UIView!
    @IBOutlet weak var JournalView: UIView!
    @IBOutlet weak var EmotionView: UIView!
    @IBOutlet weak var ActivityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 177.0/255.0, green: 222.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor, UIColor(red: 75.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.TrendScroll.frame.size.height)
        self.view.layer.insertSublayer(gradient, at:0)
        
        self.view.layer.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor

//        self.TrendScroll.layer.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor
        
        self.createShadows()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createShadows(){
        
        JournalView.layer.shadowPath = UIBezierPath(roundedRect: JournalView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        JournalView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        JournalView.layer.shouldRasterize = true
        JournalView.layer.cornerRadius = 5
        JournalView.layer.shadowColor = UIColor.black.cgColor
        JournalView.layer.shadowOpacity = 0.4
        JournalView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        JournalView.layer.shadowRadius = 2.0
        
        EmotionView.layer.shadowPath = UIBezierPath(roundedRect: EmotionView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        EmotionView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        EmotionView.layer.shouldRasterize = true
        EmotionView.layer.cornerRadius = 5
        EmotionView.layer.shadowColor = UIColor.black.cgColor
        EmotionView.layer.shadowOpacity = 0.4
        EmotionView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        EmotionView.layer.shadowRadius = 2.0
        
        
        ActivityView.layer.shadowPath = UIBezierPath(roundedRect: ActivityView.layer.bounds, cornerRadius: 5).cgPath
        //        insightsMainView.layer.shouldRasterize = true
        ActivityView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).cgColor
        ActivityView.layer.shouldRasterize = true
        ActivityView.layer.cornerRadius = 5
        ActivityView.layer.shadowColor = UIColor.black.cgColor
        ActivityView.layer.shadowOpacity = 0.4
        ActivityView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        ActivityView.layer.shadowRadius = 2.0
        
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
