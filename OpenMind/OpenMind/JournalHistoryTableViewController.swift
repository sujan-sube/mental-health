//
//  JournalHistoryTableViewController.swift
//  testing2
//
//  Created by Rehan Anwar on 2017-02-28.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit

class JournalHistoryTableViewController: UITableViewController {
    
    
    //MARK: Properties
    
    var history = [History]()
    let data = EndPointTypes.Journal
    //Listen to notification with name of endpoint and call the catchNotification method once data is received from server
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        
        APICommunication.apirequest(data: EndPointTypes.Journal , httpMethod: "GET", httpBody: nil)
//        loadSampleHistory()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
        let photo1 = UIImage(named: "Thumbsup")

        for index in 0..<id.count
        {
            guard let user = id[index] as? [String: Any],
                let content = user["content"] as? String,
                let journal_date = user["date"] as? String else {
                print ("key-value pairs do not match JSON response")
                    return
            }
            
            
            let DateandTime = DateFormatting.getStringFromDate(datestring: journal_date)
            
            //let temp = journal_date.index(journal_date.startIndex, offsetBy: 10)
            //let temp_1 = journal_date.substring(to: temp)
            
            let newEntry = History(date: DateandTime["date"]!, time: DateandTime["time"]!, photo: photo1!)
            let newIndexPath = IndexPath(row: history.count, section: 0)
            
            
            
            history.append(newEntry!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            //self.textview.font?.withSize(2)
            //self.textview.text = self.textview.text.appending("the content is \(content) and the date is " + date + "\n\n")
            
        }
        
        //Print json elements in label
        
    }
    
    //MARK :Actions
    
    @IBAction func unwindToJournalList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddJournalEntryViewController, let newentry = sourceViewController.JournalEntry {
            
            
            let newIndexPath = IndexPath(row: history.count, section: 0)
            
            history.append(newentry)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellidentifier = "HistoryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath)
            as? HistoryTableViewCell else {
                fatalError("The dequeued cell is not an instance of HistoryTableViewCell")
        }
        
        //Fetches appropriate history entry for data source layout
        
        let currenthistory = history[indexPath.row]
        
        cell.dateLabel.text = currenthistory.date
        cell.timeeLabel.text = currenthistory.time
        cell.photoImageView.image = currenthistory.photo
        
        return cell
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
