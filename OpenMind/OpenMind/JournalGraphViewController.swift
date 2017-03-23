//
//  TrendGraphViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-03-21.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import QuartzCore
import HealthKit

class JournalGraphViewController: UIViewController, LineChartDelegate {
    
    @IBOutlet weak var trendLabel: UILabel!
    
    var label = UILabel()
    var lineChart: LineChart!
    var dateArray = [String]()
//    var jourArr = [Double]()
    
    //Declare type of endpoint to hit
    let data = EndPointTypes.Journal
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        
        APICommunication.apirequest(data: EndPointTypes.Journal , httpMethod: "GET", httpBody: nil)
        
    }
    
    //Stop listening to notifications. If not included, the catchNotification method will be run multiple times.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    //Method called once data is received from the server
    
    func catchNotification(notification: Notification) -> Void {
        print("Caught Graph notification")
        
        guard let jsonResponse = notification.userInfo else {
            print("No userInfo found in notification")
            return
        }
        
        //Convert data received to dictionary of [String:Any] to parse later
        let json = APICommunication.convertDatatoDictionary(data: jsonResponse["response"] as! Data)
        
        
        //Parse json response
        guard let id = json?["results"] as? [Any] else {
            print ("Could not find results element")
            return
        }
        
        var jourArr = [Double]()
        var convertJournal = [CGFloat]()
        var dates = [String]()
        for index in 0..<6 {
            guard let user = id[index] as? [String: Any],
                let analysis = user["analysis"] as? String,
                let date = user["date"] as? String else {
                    print ("key-value pairs do not match JSON response")
                    return
            }
            
            jourArr.append((Double(analysis)!)*100)
            convertJournal = convertAnalysis(analysis: jourArr).reversed()
            dates.append(date)
            
            
        }
        
        dates = dates.reversed()
        var convertedDate = convertDate(dates: dates)
        
        self.drawGraph(journals: convertJournal, dates: convertedDate)
        
        
    }
    
    
    func convertAnalysis(analysis: [Double]) -> [CGFloat] {
        var converted = [CGFloat]()
        for point in analysis {
            converted.append(CGFloat(point))
        }
        return converted
    }
    
    func drawGraph(journals: [CGFloat], dates: [String]) {
        var views: [String: AnyObject] = [:]
        
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        // Data Arrays
        let data = journals
        //        let data2: [CGFloat] = [1, 3, 5, 13, 17, 20]
        
        
        
        // simple line with custom x axis labels
        let xLabels: [String] = dates
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 6
        lineChart.x.labels.values = xLabels
        lineChart.y.labels.visible = true
        lineChart.addLine(data)
        //        lineChart.addLine(data2)
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
        self.view.addSubview(lineChart)
        views["chart"] = lineChart
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-[chart(==200)]", options: [], metrics: nil, views: views))
        
        //        var delta: Int64 = 4 * Int64(NSEC_PER_SEC)
        //        var time = dispatch_time(DISPATCH_TIME_NOW, delta)
        //
        //        dispatch_after(time, dispatch_get_main_queue(), {
        //            self.lineChart.clear()
        //            self.lineChart.addLine(data2)
        //        });
        
        //        var scale = LinearScale(domain: [0, 100], range: [0.0, 100.0])
        //        var linear = scale.scale()
        //        var invert = scale.invert()
        //        println(linear(x: 2.5)) // 50
        //        println(invert(x: 50)) // 2.5
        
        
        
        var total = CGFloat()
        
        for analysis in journals {
            total += analysis
        }
        
        
        let average = total/CGFloat(journals.count)
        
        if journals.reversed()[0] > average {
            trendLabel.text = "You're above your expected positivity rating! Keep it up!"
            trendLabel.textColor = UIColor(red: 20.0/255.0, green: 125.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        } else {
            trendLabel.text = "You're a bit below your expected positivity rating. Check out the Insights page for some tips!"
            trendLabel.textColor = UIColor.blue
        }
        
        
    }
    
    func convertDate(dates: [String]) -> [String] {
        
        var convertDates = [String]()
        
        for dateString in dates {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone(abbreviation: "ET")
            let date = dateFormatter.date(from: dateString)
            dateFormatter.dateFormat = "MM-dd"
            convertDates.append(dateFormatter.string(from: date!))
        }
        
    
        return convertDates
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /**
     * Line chart delegate method.
     */
    func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>) {
        label.text = "Positivity Percentage: \(yValues[0])"
        
    }
    
    
    
    /**
     * Redraw chart on device rotation.
     */
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }
    
}
