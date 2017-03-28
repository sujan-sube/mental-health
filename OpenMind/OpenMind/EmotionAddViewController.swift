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
    
    
    @IBOutlet weak var TakeImageLabel: UILabel!
    
    let picker = UIImagePickerController()

    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!

    let data = EndPointTypes.Journal
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SubmitButton.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 100/255.0, alpha: 1).cgColor
        
        picker.delegate = self
        
        self.TakeImageLabel.isHidden = false;

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
        
        self.TakeImageLabel.isHidden = true;
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func SubmitImage(_ sender: Any) {
        
        UploadImageRequest()
    }
    
    
    func UploadImageRequest()
    {
        
        let myUrl = NSURL(string: "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/emotion/");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        let param = [
            "firstName"  : "Sergey",
            "lastName"    : "Kargopolov",
            "userId"    : "9"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("eyJhbGciOiJSUzI1NiIsImtpZCI6IjZiZjVlYTM1MWJiMzJjNmZlNjE5ZWM5YTBmOGU4MDMyOWJjZGFkNTEifQ.eyJhenAiOiIyNDQwOTA2NDIwNjYtMDNpcWxwcTU0b205dTRkYTRodTZnZmtibm8xMHBxbGIuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIyNDQwOTA2NDIwNjYtNzg5aWk1bmY2MzhvODFvamNzbGJxZmxncW9ibjExNHAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTE0Nzk5Nzk5NTk5NTE3MzM3NTkiLCJlbWFpbCI6Im9wZW5taW5kaGVhbHRoQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiQzI5MGpQNy10VVAxSERzcHg3QVVKdyIsImlzcyI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbSIsImlhdCI6MTQ5MDY2MjA5NywiZXhwIjoxNDkwNjY1Njk3fQ.q1VG0-ClqUJT2-twuuwzcGt90snsSqOUw_EaF1rohyrC9y2b6a3oQhG5Bi6b3VCpEdGr0exSHcnvunMzh_h0wgLEIDrr9tMjCEkZejhid1Rf01KfLWBy9XFHAPEp2ITjR7Wsvj71g3BRj8PkyKBSci1uc5_gydnJMTLITliXGE3_nLRsvmcpyDrLmnGUw-8j7l5TBWWJ6RxJnw40_RNf8EthbAj-Y4dcNNe1huGmE6bCGf-sobNfBfnCDDnEA25EcQFTjBhc3c09dRa1gyz45jtuNW1AglehQtf9cA0KS6Qa6BQSsOFb8nsY2M0nXPQ_s3PvUiEu2iJQeYWAOHf8cQ", forHTTPHeaderField: "token")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "image", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
        myActivityIndicator.startAnimating();
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                
                print(json)
                
                DispatchQueue.main.async(execute: {
                    self.myActivityIndicator.stopAnimating()
                    self.myImageView.image = nil;
                });
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

