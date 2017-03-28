//
//  ServerEndpoints.swift
//  apiconnection2
//gggtg
//  Created by Rehan Anwar on 2017-03-12.
//  Copyright © 2017 Rehan Anwar. All rights reserved.
//

import Foundation
import Google
import GoogleSignIn

//Different server endpoints to hit and obtain data

enum EndPointTypes : String {
    case Journal = "Journal"
    case Graph = "Graph"
    case Emotion = "Emotion"
    case History = "History"
    case SignIn = "SignIn"
    case Insights = "Insights"
    case Profile = "Profile"

}


func getserveraddress (data: EndPointTypes) -> String
{
    switch data{
        
    case .Journal:
//        print("journal passed in")
        EndPoint = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/journal/"
        NotificationName = data.rawValue
    case .Emotion:
//        print("emotion passed in")
        EndPoint = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/emotion/"
        NotificationName = data.rawValue
    case .History:
//        print("history passed in")
        EndPoint = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/rest-auth/login/"
        NotificationName = data.rawValue
    case .Graph:
//        print("graph passed in")
        EndPoint = "https://jsonplaceholder.typicode.com/posts/1"
        NotificationName = data.rawValue
    case .SignIn:
//        print("SignIn passed in")
        EndPoint = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/rest-auth/google/"
        NotificationName = data.rawValue
    case .Insights:
//        print("journal passed in")
        EndPoint = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/insight/"
        NotificationName = data.rawValue
    case .Profile:
        //        print("journal passed in")
        EndPoint = "http://ec2-52-39-73-116.us-west-2.compute.amazonaws.com/rest-auth/user/"
        NotificationName = data.rawValue
    }
    
    return EndPoint
    
}
