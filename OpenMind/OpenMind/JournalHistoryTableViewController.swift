//
//  JournalHistoryTableViewController.swift
//  testing2
//
//  Created by Rehan Anwar on 2017-02-28.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class JournalHistoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableview: UITableView!
    //MARK: Properties
    
    var history = [History]()
    let data = EndPointTypes.Journal
    //Listen to notification with name of endpoint and call the catchNotification method once data is received from server
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.backgroundColor = UIColor.clear
        
        
        
//        APICommunication.apirequest(data: EndPointTypes.Journal , httpMethod: "GET", httpBody: nil)
//        loadSampleHistory()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        history.removeAll()
        tableview.reloadData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        APICommunication.apirequest(data: EndPointTypes.Journal , httpMethod: "GET", httpBody: nil)
        
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
        print("Caught Graph notification")
        
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
                let content = user["content"] as? String,
                let analysis = user["analysis"] as? String,
                let journal_date = user["date"] as? String else {
                print ("key-value pairs do not match JSON response")
                    continue
            }
            
            
            
            let DateandTime = DateFormatting.getStringFromDate(datestring: journal_date)
            
            var photo : UIImage!

            
            if  Double(analysis)! < 0.4 {
                photo = UIImage(named: "SadEntry")
            }
            else if Double(analysis)! > 0.4 && Double(analysis)! < 0.7 {
                photo = UIImage(named: "ModerateEntry")
            }
            else
            {
                photo = UIImage(named: "PositiveEntry")
            }
            
            let newEntry = History(date: DateandTime["date"]!, time: DateandTime["time"]!, photo: photo!, DatabaseDate: journal_date)
            
            let newIndexPath = IndexPath(row: history.count, section: 0)
            
            
            
            history.append(newEntry!)
            self.tableview.beginUpdates()
            self.tableview.insertRows(at: [newIndexPath], with: .automatic)
            self.tableview.endUpdates()
            //self.textview.font?.withSize(2)
            //self.textview.text = self.textview.text.appending("the content is \(content) and the date is " + date + "\n\n")
            
        }
        
        //Print json elements in label
        DispatchQueue.main.async{
            self.tableview.reloadData()
        }
    }
    
    //MARK :Actions
    
    @IBAction func unwindToJournalList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddJournalEntryViewController, let newentry = sourceViewController.JournalEntry {
            
            
            let newIndexPath = IndexPath(row: history.count, section: 0)
            
            history.append(newentry)
            self.tableview.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
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
        return history.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellidentifier = "HistoryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath)
            as? HistoryTableViewCell else {
                fatalError("The dequeued cell is not an instance of HistoryTableViewCell")
        }
        
        cell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        cell.layer.borderWidth = 1.0
        //cell.contentView.backgroundColor = UIColor.clear
        
        //Fetches appropriate history entry for data source layout
        
        let currenthistory = history[indexPath.row]
        
        cell.dateLabel.text = currenthistory.date
        cell.timeeLabel.text = currenthistory.time
        cell.photoImageView.image = currenthistory.photo
        cell.DatabaseDate = currenthistory.DatabaseDate
        
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if such cell exists and destination controller (the one to show) exists too..
        if let JournalEntryCell = tableView.cellForRow(at: indexPath) as? HistoryTableViewCell, let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "DestinationVC") as? IndividualJournalPageViewController{
            //This is a bonus, I will be showing at destionation controller the same text of the cell from where it comes...
    
            if let date = JournalEntryCell.dateLabel.text, let time = JournalEntryCell.timeeLabel.text,
                let DatabaseDate = JournalEntryCell.DatabaseDate {
                destinationViewController.date = date
                destinationViewController.time = time
                destinationViewController.DatabaseDate = DatabaseDate

            } else {
                destinationViewController.date = "No Date"
                destinationViewController.time = "No Time"
                destinationViewController.DatabaseDate = "2017-03-16T22:26:55Z"

            }
            //Then just push the controller into the view hierarchy
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
