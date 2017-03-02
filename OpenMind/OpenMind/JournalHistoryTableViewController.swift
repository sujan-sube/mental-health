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
    
    //MARK :Actions
    
    @IBAction func unwindToJournalList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddJournalEntryViewController, let newentry = sourceViewController.JournalEntry {
            
            
            let newIndexPath = IndexPath(row: history.count, section: 0)
            
            history.append(newentry)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
    
    
    //Mark: Private Methods 
    
    private func loadSampleHistory() {
        
        let photo1 = UIImage(named: "Thumbsup")
        let photo2 = UIImage(named: "Thumbsdown")
        let photo3 = UIImage(named: "Thumbsup")
        let photo4 = UIImage(named: "Thumbsup")
        
        guard let history1 = History(date: "Mar 1, 2017", photo: photo1!) else {
            fatalError("Unable to instantiate history1")
        }
        
        guard let history2 = History(date: "Mar 2, 2017", photo: photo2!) else {
            fatalError("Unable to instantiate history2")
        }
        
        guard let history3 = History(date: "Mar 3, 2017", photo: photo3!) else {
            fatalError("Unable to instantiate history3")
        }
        
        guard let history4 = History(date: "Mar 4, 2017", photo: photo4!) else {
            fatalError("Unable to instantiate history4")
        }
        history += [history1, history2, history3, history4]
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the sample history data
        loadSampleHistory()
    }

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
