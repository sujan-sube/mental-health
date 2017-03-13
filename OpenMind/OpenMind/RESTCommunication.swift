//
//  RESTCommunication.swift
//  OpenMind
//
//  Created by Shirshak Shrestha on 2017-02-20.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import Foundation

class RESTCommunication {
    
    // Send Request to the server
    static func sendRequest(_ serverAddress:String, _ type:String, _ headers:String?, _ body:Data?) -> String{
        var token:String = ""
        var request = URLRequest(url: URL(string: serverAddress)!)
        
        request.httpMethod = type
        if (headers != nil){
            //Add headers here
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if (body != nil){
        request.httpBody = body
        }
        //print(String(data: body, encoding: String.Encoding.utf8))
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            token = self.jsonToString(json: json)
        }
        
        task.resume()
        //let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        
        return token
    }
    
    static func getToken(_ serverAddress:String, _ idToken:String) {
        
        
        let jsonObject: [String: AnyObject]  = [
                "code": idToken as AnyObject
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        //print (jsonObject)
        let accessToken = self.sendRequest(serverAddress, "POST", nil, jsonData!)
        print (accessToken)
    }
    
    static func test_journal(_ serverAddress:String) {
    
        //print (jsonObject)
        let accessToken = self.sendRequest(serverAddress, "GET", nil, nil)
    }
    
    static func jsonToString(json: AnyObject) -> String{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            return convertedString!
            
        } catch let myJSONError {
            return myJSONError as! String
        }
        
    }
    
    
    
    
    
    
}
