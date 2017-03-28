//
//  InsightsTableViewController.swift
//  apiconnection2
//
//  Created by Shirshak Shrestha on 2017-03-18.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class InsightsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

//    var  insightsTopic = [String]()
//    var  insightsDetails = [String]()
    var insights = [Insights]()
//    var insightsImage = [UIImage]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func dismissOnClick(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        //insightsTopic = ["Physical Activity", "Emotion", "Physical Activity"]
        //insightsDetails = ["Run", "be happy", "workout"]
//        loadSampleInsights()
        // Do any additional setup after loading the view.
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 177.0/255.0, green: 222.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor, UIColor(red: 75.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.animateProgress(angle: 300)
//        self.navigationController?.navigationBar.isHidden = true
        insights.removeAll()
        tableView.reloadData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + EndPointTypes.Insights.rawValue),
            object: nil)
        APICommunication.apirequest(data: EndPointTypes.Insights , httpMethod: "GET", httpBody: nil)
        
    }
    
    //Stop listening to notifications. If not included, the catchNotification method will be run multiple times.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        return insights.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // 3
        let cell = tableView.dequeueReusableCell(withIdentifier: "insightsCell", for: indexPath) as!InsightsTableViewCell
        
        //cell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        cell.insightsTopic.text = insights[indexPath.row].insightsTopic
        cell.insightsDetails.text = insights[indexPath.row].insightsInfo
        cell.insightsImage.image = insights[indexPath.row].photo
//        if insights[indexPath.row].insightsTopic == "Emotion"
//        {
//            cell.insightsMainView.backgroundColor = UIColor(red: 250.0/255.0, green: 128.0/255.0, blue: 114.0/255.0, alpha: 1.0)
//            cell.insightsTopic.textColor = UIColor.white
//            cell.insightsDetails.textColor = UIColor.white
//        }
//        else if insights[indexPath.row].insightsTopic == "Sleep Activity"
//        {
//            cell.insightsMainView.backgroundColor = UIColor(red: 224.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//            cell.insightsTopic.textColor = UIColor.white
//            cell.insightsDetails.textColor = UIColor.white
//        }
//        else if insights[indexPath.row].insightsTopic == "Physical Activity"
//        {
//            cell.insightsMainView.backgroundColor = UIColor(red: 255.0/255.0, green: 215.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//            cell.insightsTopic.textColor = UIColor.white
//            cell.insightsDetails.textColor = UIColor.white
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let viewCell = tableView.cellForRow(at: indexPath) as? InsightsTableViewCell,
        if let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "InsightsDestinationVC") as? IndividualInsightsPageViewController{
            //                let index = tableView.indexPath(for: viewCell)
            destinationViewController.insight = insights[indexPath.row]
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }


    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            insights.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            tableView.reloadData()
        }
    }

    func loadSampleInsights(){
        var newEntry = Insights(insightsTopic: "Physical", insightsInfo: "Run", photo: #imageLiteral(resourceName: "green"))
        insights.append(newEntry!)
        newEntry = Insights(insightsTopic: "Emotional", insightsInfo: "Clear you mind", photo: #imageLiteral(resourceName: "green"))
        insights.append(newEntry!)
        newEntry = Insights(insightsTopic: "Emotional", insightsInfo: "Review your journal", photo: #imageLiteral(resourceName: "green"))
        insights.append(newEntry!)
    }
    
    func catchNotification(notification: Notification) -> Void {
        print("Caught Insights notification")
        
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
            guard let insight = id[index] as? [String: Any],
                let topic = insight["topic"] as? String,
                let info = insight["info"] as? String,
                let detail = insight["detail"] as? String,
                let insight_date = insight ["date"] as? String else {
                    print ("key-value pairs do not match JSON response")
                    return
            }
            
//            let dateTime = DateFormatting.getStringFromDate(datestring: insight_date)
           
            
//            let DateandTime = DateFormatting.getStringFromDate(datestring: journal_date)
            
            var photo : UIImage!
            
//            photo = #imageLiteral(resourceName: "green")
            if topic == "Emotion"
            {
                photo = #imageLiteral(resourceName: "emotion")
            }
            else if topic == "Sleep Activity"
            {
                photo = #imageLiteral(resourceName: "green")
            }
            else if topic == "Physical Activity"
            {
                photo = #imageLiteral(resourceName: "phy act")
            }
//            if  Double(analysis)! < 0.4 {
//                photo = UIImage(named: "SadEntry")
//            }
//            else if Double(analysis)! > 0.4 && Double(analysis)! < 0.7 {
//                photo = UIImage(named: "ModerateEntry")
//            }
//            else
//            {
//                photo = UIImage(named: "PositiveEntry")
//            }
//            
            let newEntry = Insights(insightsTopic: topic, insightsInfo: info, photo: photo, detail: detail)
            
            let newIndexPath = IndexPath(row: insights.count, section: 0)
            
            
            
            insights.append(newEntry!)
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            //self.textview.font?.withSize(2)
            //self.textview.text = self.textview.text.appending("the content is \(content) and the date is " + date + "\n\n")
            
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

}
