//
//  EmotionHistoryViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-18.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class EmotionHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var history = [History]()
    let numberofcells = 5
    
    let dates = ["Saturday, March 18", "Saturday, March 18", "Saturday, March 18", "Saturday, March 18", "Saturday, March 18"]
    
    let times = ["7:15 PM", "7:15 PM", "7:15 PM", "7:15 PM", "7:15 PM" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        
    
        populateEmotionCells()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        if let JournalEntryCell = tableView.cellForRow(at: indexPath) as? HistoryTableViewCell, let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "EmotionDestinationVC") as? EmotionIndividualEntryViewController{
            //This is a bonus, I will be showing at destionation controller the same text of the cell from where it comes...
            
            navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }

    
    func populateEmotionCells() -> Void {
        
        
        
        let history1 = History(date: dates[0], time: times[0], photo: UIImage(named: "ModerateEntry")!, DatabaseDate: "hello")!
        let history2 = History(date: dates[1], time: times[1], photo: UIImage(named: "ModerateEntry")!, DatabaseDate: "hello")!
        let history3 = History(date: dates[2], time: times[2], photo: UIImage(named: "ModerateEntry")!, DatabaseDate: "hello")!
        let history4 = History(date: dates[3], time: times[3], photo: UIImage(named: "ModerateEntry")!, DatabaseDate: "hello")!
        let history5 = History(date: dates[4], time: times[4], photo: UIImage(named: "ModerateEntry")!, DatabaseDate: "hello")!
        
        
        history += [history1, history2, history3, history4, history5]
        
        return
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
