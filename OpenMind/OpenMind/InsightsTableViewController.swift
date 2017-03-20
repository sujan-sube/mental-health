//
//  InsightsTableViewController.swift
//  apiconnection2
//
//  Created by Shirshak Shrestha on 2017-03-18.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class InsightsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var  insightsTopic = [String]()
    var  insightsDetails = [String]()
//    var insightsImage = [UIImage]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        insightsTopic = ["Physical Activity", "Emotion", "Physical Activity"]
        insightsDetails = ["Run", "be happy", "workout"]

        // Do any additional setup after loading the view.
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 177.0/255.0, green: 222.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor, UIColor(red: 75.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.animateProgress(angle: 300)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        return insightsTopic.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // 3
        let cell = tableView.dequeueReusableCell(withIdentifier: "insightsCell", for: indexPath) as!InsightsTableViewCell
        
        //cell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        cell.insightsTopic.text = insightsTopic[indexPath.row]
        cell.insightsDetails.text = insightsDetails[indexPath.row]
        cell.insightsImage.image = #imageLiteral(resourceName: "green")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewCell = tableView.cellForRow(at: indexPath) as? TodayTableViewCell
//        if (viewCell?.typeLabel.text == "Journal"){
//            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "journalHistoryTableView") as? JournalHistoryTableViewController {
//                //viewController.newsObj = newsObj
//                if let navigator = navigationController {
//                    navigator.pushViewController(viewController, animated: true)
//                }
//            }        }
//        
        
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
