//
//  APIConnection.swift
//  apiconnection2
//
//  Created by Rehan Anwar on 2017-03-11.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//



import Foundation

var EndPoint = String()
var NotificationName = String()

class APICommunication {
    
    
    
    //Takes EndPointType, the method and the body to post and connect to API.
    //Posts response data to NotificationCenter with EndPointType NotificationName
    
    static func apirequest(data: EndPointTypes, httpMethod: String, httpBody: [String: Any]?, signInBool: Bool = false) -> Void {
        
        
        let datatype = data
        EndPoint = getserveraddress(data: datatype)
        
        
        if httpMethod == "GET" && httpBody != nil {
            print("this i running the get method")
            EndPoint = createGetURL(httpBody: httpBody!, PreviousEndPoint: EndPoint)
            
        }
        
        let url = URL(string: EndPoint)
        var urlRequest = NSMutableURLRequest(url: url!)
        urlRequest.httpMethod = httpMethod
        
        if httpMethod == "GET" {
            createGetBody(urlRequest: &urlRequest, httpMethod: httpMethod)
        }
        
        if httpMethod=="POST" && signInBool == false {
            createPostBody(urlRequest: &urlRequest, httpMethod: httpMethod, httpDictionary: httpBody)
        }
        
        if httpMethod=="POST" && signInBool == true {
            createSignInPostBody(urlRequest: &urlRequest, httpMethod: httpMethod, httpDictionary: httpBody)
        }
        

        
        let session = URLSession.shared
        
        let myCompletionHandler: (Data?, URLResponse?, Error?) -> Void = {
            (data, response, error) in
            // this is where the completion handler code goes
            
            guard error == nil else {
                print ("Error calling GET request")
                print (error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let dictionary: NSDictionary = ["response": responseData]
            
            let httpResponse = response as? HTTPURLResponse
            
            if (httpResponse?.statusCode)!/100  == 2 {
                DispatchQueue.main.async {
            
                    //Listen to this notification in your viewcontroller to get data
                    NotificationCenter.default.post(name:Notification.Name(rawValue:"MyNotification" + datatype.rawValue),
                                            object: nil,
                                            userInfo: dictionary as? [AnyHashable : Any])
                }
            }
            
            if httpResponse?.statusCode == 400{
                print ("Bad Response")
            }
            
            if httpResponse?.statusCode == 401{
                print ("Authorization Error")
            }
            
            if httpResponse?.statusCode == 403{
                print ("Forbidden Request")
            }
            
        }
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: myCompletionHandler)
        
        task.resume()
        
    }
    
    static func createGetURL(httpBody: [String: Any], PreviousEndPoint: String) ->String{
        
        guard let urlextension = httpBody["date"] as? String else {
            print ("not correct parameters in GET Request")
            return EndPoint
        }
//        print("ID Token: " + GIDSignIn.sharedInstance().currentUser.authentication.idToken)
        return EndPoint + "?date=" + urlextension
        
        
    }

    
    static func createGetBody (urlRequest: inout NSMutableURLRequest, httpMethod: String)
    {
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: httpDictionary!)
//        urlRequest.httpBody = jsonData
        checkIdTokenExpiry()
        urlRequest.allHTTPHeaderFields = ["token": GIDSignIn.sharedInstance().currentUser.authentication.idToken]
//        print ("ID Token: " + GIDSignIn.sharedInstance().currentUser.authentication.idToken)
    }
    
    static func createPostBody (urlRequest: inout NSMutableURLRequest, httpMethod: String, httpDictionary:[String:Any]?)
    {
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let jsonData = try? JSONSerialization.data(withJSONObject: httpDictionary!)
        urlRequest.httpBody = jsonData
        urlRequest.allHTTPHeaderFields = ["token": GIDSignIn.sharedInstance().currentUser.authentication.idToken,
                                          "Content-Type": "application/json"]
        
    }
    
    static func createSignInPostBody (urlRequest: inout NSMutableURLRequest, httpMethod: String, httpDictionary:[String:Any]?)
    {
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let jsonData = try? JSONSerialization.data(withJSONObject: httpDictionary!)
        urlRequest.httpBody = jsonData
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
    }
    
    
    //Converts response data to Dictionary of type [String:Any] which can be parsed
    
    static func convertDatatoDictionary (data: Data) -> [String: Any]?
    {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                else {
                    print("error trying to convert data to JSON")
                    return nil
            }
            
            return json
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
    
    static func checkIdTokenExpiry()
    {
        if (Date() > GIDSignIn.sharedInstance().currentUser.authentication.idTokenExpirationDate)
        {
            GIDSignIn.sharedInstance().signInSilently()
//            GIDSignIn.sharedInstance().currentUser.authentication.refreshTokens(handler: (GIDAuthentication, NSError) -> GIDAuthentication = { (authentication, error)
//                
//            })
            
//            }
        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        let dateString = dateFormatter.string(from:GIDSignIn.sharedInstance().currentUser.authentication.idTokenExpirationDate)
//        print ("Expiration date: " + dateString)
    }
    
    
    
}
