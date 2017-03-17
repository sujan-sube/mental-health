//
//  DateFormatting.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-15.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import Foundation


class DateFormatting{
    

    static func getStringFromDate(datestring: String) -> [String:String]
{
    let dateformatter = DateFormatter()
    
    dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    guard let date = dateformatter.date(from: datestring) else {
        print("did not receive date")
        return ["date":"No Date","time":"no time"]
    }
    
    
    dateformatter.dateFormat = "EEEE, MMMM dd"
    dateformatter.timeZone = TimeZone(abbreviation: "ET")
    let modified_journal_date = dateformatter.string(from: date)
    
    dateformatter.dateFormat = "h:mm a."
    let modified_journal_time = dateformatter.string(from: date)
    
    let DateandTime = ["date":modified_journal_date, "time":modified_journal_time]
    
    return DateandTime
    
}
    static func getCurrentDate() -> String {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateformatter.timeZone = TimeZone(abbreviation: "ET")
        
        let DateandTime = dateformatter.string(from: date)
        
        return DateandTime

        

    }
}
