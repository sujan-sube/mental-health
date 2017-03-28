//
//  EmotionAddViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import os.log
import CDAlertView
import SpringIndicator

class EmotionAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let picker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var LoadingIndicator: SpringIndicator!
    let data = EndPointTypes.Journal
    
    @IBOutlet weak var JournalTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SubmitButton.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 100/255.0, alpha: 1).cgColor
        
        picker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        
        @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
            picker.popoverPresentationController?.barButtonItem = sender
        }
        
        @IBAction func shootPhoto(_ sender: UIButton) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                noCamera()
            }
        }
        func noCamera(){
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            alertVC.addAction(okAction)
            present(
                alertVC,
                animated: true,
                completion: nil)
        }
    

        //MARK: - Delegates
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [String : AnyObject])
        {
            var  chosenImage = UIImage()
            chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            myImageView.contentMode = .scaleAspectFit //3
            myImageView.image = chosenImage //4
            dismiss(animated:true, completion: nil) //5
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
}
