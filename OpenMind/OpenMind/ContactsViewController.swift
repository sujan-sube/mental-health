//
//  ContactsViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-01-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var FindHelpButton: UIButton!
    @IBOutlet weak var MomImage: UIImageView!
    @IBOutlet weak var DrImage: UIImageView!
    @IBOutlet weak var DadImage: UIImageView!
    @IBOutlet weak var MessageButton: UIButton!
    @IBOutlet weak var MomCell: UIView!
    @IBOutlet weak var DadCell: UIView!
    @IBOutlet weak var DrCell: UIView!
    @IBOutlet weak var MessageCell: UIView!
    
    let messageComposer = MessageComposer()
    
    let cellbordercolor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
    
    let cellborderwidth: CGFloat = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MomCell.layer.cornerRadius = 5
        MomCell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        MomCell.layer.borderColor = cellbordercolor
        MomCell.layer.borderWidth = cellborderwidth
        
        DadCell.layer.cornerRadius = 5
        DadCell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        DadCell.layer.borderColor = cellbordercolor
        DadCell.layer.borderWidth = cellborderwidth
        
        DrCell.layer.cornerRadius = 5
        DrCell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        DrCell.layer.borderColor = cellbordercolor
        DrCell.layer.borderWidth = cellborderwidth
        
        MessageCell.layer.cornerRadius = 10
        MessageCell.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 100/255.0, alpha: 1).cgColor
        
        self.FindHelpButton.layer.cornerRadius = 10
        self.FindHelpButton.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 100/255.0, alpha: 1).cgColor
        self.FindHelpButton.tintColor = UIColor.white
        
        MomImage.image = #imageLiteral(resourceName: "ContactsIcon")
        DrImage.image = #imageLiteral(resourceName: "ContactsIcon")
        DadImage.image = #imageLiteral(resourceName: "ContactsIcon")
        MessageButton.tintColor = UIColor.white
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 177.0/255.0, green: 222.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor, UIColor(red: 75.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MessageButton(_ sender: Any) {
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            present(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
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
