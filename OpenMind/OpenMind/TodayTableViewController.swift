//
//  TodayTableViewController.swift
//  OpenMind
//
//  Created by Shirshak Shrestha on 2017-03-17.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import Foundation
import UIKit

class TodayTableViewController: UITableViewController {
    
    var  attributes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        attributes = ["Journal", "Emotion", "Exercise"]
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
        // 2
        return attributes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // 3
        let cell = tableView.dequeueReusableCell(withIdentifier: "attributeCell", for: indexPath) as!TodayTableViewCell
        
        cell.typeLabel.text = attributes[indexPath.row]
        return cell
    }

}
