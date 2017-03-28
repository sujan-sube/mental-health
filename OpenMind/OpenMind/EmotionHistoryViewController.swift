////
////  EmotionHistoryViewController.swift
////  OpenMind
////
////  Created by Rehan Anwar on 2017-03-18.
////  Copyright © 2017 Aly Haji. All rights reserved.
////
//'



//
//  JournalHistoryTableViewController.swift
//  testing2
//
//  Created by Rehan Anwar on 2017-02-28.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class EmotionHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableview: UITableView!
    //MARK: Properties
    
    var emotionHistory = [EmotionModel]()
    let data = EndPointTypes.Emotion
    
    //Listen to notification with name of endpoint and call the catchNotification method once data is received from server
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.backgroundColor = UIColor.clear
        
        
        
        //        APICommunication.apirequest(data: EndPointTypes.Journal , httpMethod: "GET", httpBody: nil)
        //        loadSampleHistory()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emotionHistory.removeAll()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        APICommunication.apirequest(data: data , httpMethod: "GET", httpBody: nil)
        tableview.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableview.reloadData()
    }
    
    //Stop listening to notifications. If not included, the catchNotification method will be run multiple times.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func catchNotification(notification: Notification) -> Void {
        print("Caught Emotion notification")
        
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
            guard let user = id[index] as? [String: Any],
                let emotion_date = user["date"] as? String,
                let emotion_image_url = user["image"] as? String,
                let emotion_max_expression = user["max_expression"] as? String,
                let expressions = user["expressions"] as? [String:String]
                else {
                    print ("key-value pairs do not match JSON response")
                    
                    
                    continue
            }
            
            
            
            let DateandTime = DateFormatting.getStringFromDate(datestring: emotion_date)
            
            var photo : UIImage!
            
            if  (emotion_max_expression == "happiness") {
                photo = UIImage(named: "SadEntry")
            }
                
            else if  (emotion_max_expression == "neutral") {
                photo = UIImage(named: "ModerateEntry")
            }
                
            else if  (emotion_max_expression == "sadness") {
                photo = UIImage(named: "SadEntry")
            }
                
            else {
                photo = UIImage(named: "SadEntry")
            }
            
            let newEntry = EmotionModel(date: DateandTime["date"]!, time: DateandTime["time"]!, photo: photo!, DatabaseDate: emotion_date, imageurl : emotion_image_url, expressions: expressions)
            
            
            let newIndexPath = IndexPath(row: emotionHistory.count, section: 0)
            
            
            
            emotionHistory.append(newEntry!)
            self.tableview.beginUpdates()
            self.tableview.insertRows(at: [newIndexPath], with: .automatic)
            self.tableview.endUpdates()
//            self.textview.font?.withSize(2)
//            self.textview.text = self.textview.text.appending("the content is \(content) and the date is " + date + "\n\n")
            
            //
            //            let DateandTime = DateFormatting.getStringFromDate(datestring: journal_date)
            //
            //            var photo : UIImage!
            //
            //
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
            //            let newEntry = History(date: DateandTime["date"]!, time: DateandTime["time"]!, photo: photo!, DatabaseDate: journal_date)
            
            //let newIndexPath = IndexPath(row: history.count, section: 0)
            
            
            
            //            history.append(newEntry!)
            //            self.tableview.beginUpdates()
            //            self.tableview.insertRows(at: [newIndexPath], with: .automatic)
            //            self.tableview.endUpdates()
            //self.textview.font?.withSize(2)
            //self.textview.text = self.textview.text.appending("the content is \(content) and the date is " + date + "\n\n")
            
        }
        
        //Print json elements in label
        DispatchQueue.main.async{
            self.tableview.reloadData()
        }
    }
    
    //MARK :Actions
    
//    @IBAction func unwindToJournalList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? AddJournalEntryViewController, let newentry = sourceViewController.JournalEntry {
//            
//            
//            let newIndexPath = IndexPath(row: emotionHistory.count, section: 0)
//            
//            emotionHistory.append(newentry)
//            self.tableview.insertRows(at: [newIndexPath], with: .automatic)
//        }
//    }
    
    private func find_Pic() -> UIImage{
        let pic = UIImage(named: "Thumbsup")
        return pic!
    }
    
    
    //Mark: Private Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellidentifier = "EmotionTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath)
            as? EmotionTableViewCell else {
                fatalError("The dequeued cell is not an instance of EmotionTableViewCell")
        }
        
        cell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        cell.layer.borderWidth = 1.0
        //cell.contentView.backgroundColor = UIColor.clear
        
        //Fetches appropriate history entry for data source layout
        
        let currenthistory = emotionHistory[indexPath.row]
        
        cell.dateLabel.text = currenthistory.date
        cell.timeeLabel.text = currenthistory.time
        cell.photoImageView.image = currenthistory.photo
        cell.DatabaseDate = currenthistory.DatabaseDate
        cell.imageurl = currenthistory.imageurl
        cell.expressions = currenthistory.expressions
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if such cell exists and destination controller (the one to show) exists too..
        if let EmotionEntryCell = tableView.cellForRow(at: indexPath) as? EmotionTableViewCell, let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "EmotionImageDestinationVC") as? EmotionImageIndividualEntryViewController{
            //This is a bonus, I will be showing at destionation controller the same text of the cell from where it comes...
            
            if let date = EmotionEntryCell.dateLabel.text, let time = EmotionEntryCell.timeeLabel.text, let imageurl = EmotionEntryCell.imageurl, let expressions = EmotionEntryCell.expressions,
                let DatabaseDate = EmotionEntryCell.DatabaseDate {
                destinationViewController.date = date
                destinationViewController.time = time
                destinationViewController.imageurl = imageurl
                destinationViewController.DatabaseDate = DatabaseDate
                destinationViewController.expressions = expressions
                
            } else {
                destinationViewController.date = "No Date"
                destinationViewController.time = "No Time"
                destinationViewController.imageurl = nil
                destinationViewController.DatabaseDate = "2017-03-16T22:26:55Z"
                
            }
            //Then just push the controller into the view hierarchy
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
}
