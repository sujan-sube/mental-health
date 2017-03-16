//
//  ViewController.swift
//  testing2
//
//  Created by Rehan Anwar on 2017-02-28.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import UIKit
import os.log


class AddJournalEntryViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    
    @IBOutlet weak var JournalTextView: UITextView!
    

    @IBOutlet weak var saveButton: UIButton!
    
    
    var JournalEntry : History?
    
    
    
    
    //MARK: Navigation
    
    
    
    // This method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let JournalText = JournalTextView.text ?? ""
        let date = "March 55 2017"
        let dummyphoto = UIImage(named: "Thumbsup")
        
        JournalEntry = History(date: date, time:date, photo: dummyphoto!)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

