//
//  EmotionGraphViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-03-27.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import QuartzCore
import HealthKit

class EmotionGraphViewController: UIViewController, LineChartDelegate {
    
    
    
    @IBOutlet weak var trendLabel: UILabel!
    
    var label = UILabel()
    var lineChart: LineChart!
    var dateArray = [String]()
    //    var jourArr = [Double]()
    
    //Declare type of endpoint to hit
    let data = EndPointTypes.Emotion
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.catchNotification2(notification:)),
//            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
//            object: nil)
//        
//        APICommunication.apirequest(data: data , httpMethod: "GET", httpBody: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.catchNotification2(notification:)),
            name: Notification.Name(rawValue:"MyNotification" + self.data.rawValue),
            object: nil)
        APICommunication.apirequest(data: EndPointTypes.Emotion , httpMethod: "GET", httpBody: nil)
    }
    
    //Stop listening to notifications. If not included, the catchNotification method will be run multiple times.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    //Method called once data is received from the server
    
    func catchNotification2(notification: Notification) -> Void {
        print("Caught Emotion notification")
        
        guard let jsonResponse = notification.userInfo else {
            print("No userInfo found in notification")
            return
        }
        
        //Convert data received to dictionary of [String:Any] to parse later
        let json = APICommunication.convertDatatoDictionary(data: jsonResponse["response"] as! Data)
        
        
        //Parse json response
        guard let id1 = json?["results"] as? [Any] else {
            print ("Could not find results element")
            return
        }
        
        var emotionArr = [Double]()
        var convertEmotion = [CGFloat]()
        var dates = [String]()
        var check = true
        var points: Int = 0
        if id1.count >= 6 {
            points = 6
        }
        else if (id1.count < 6) && (id1.count >= 2) {
            points = id1.count
        }
        else {
            check = false
        }
        
        if (check) {
            
            for index in 0..<points {
                guard let user = id1[index] as? [String: Any],
                    let analysis = user["max_expression"] as? String,
                    let date = user["date"] as? String else {
                        print ("key-value pairs do not match JSON response")
                        continue
                }
                
                var emotionNum: Double = 0
                if analysis == "happiness" {
                    emotionNum = 8
                }
                else if analysis == "surprise" {
                    emotionNum = 7
                }
                else if analysis == "neutral" {
                    emotionNum = 6
                }
                else if analysis == "disgust" {
                    emotionNum = 5
                }
                else if analysis == "contempt" {
                    emotionNum = 4
                }
                else if analysis == "anger" {
                    emotionNum = 3
                }
                else if analysis == "sadness" {
                    emotionNum = 2
                }
                else if analysis == "fear" {
                    emotionNum = 1
                }
                emotionArr.append(emotionNum)
                convertEmotion = convertAnalysis(analysis: emotionArr).reversed()
                dates.append(date)
                
                
            }
            
            dates = dates.reversed()
            var convertedDate = convertDate(dates: dates)
            
            self.drawGraph(emotions: convertEmotion, dates: convertedDate)
            
        }
        
        
    }
    
    
    func convertAnalysis(analysis: [Double]) -> [CGFloat] {
        var converted = [CGFloat]()
        for point in analysis {
            converted.append(CGFloat(point))
        }
        return converted
    }
    
    func drawGraph(emotions: [CGFloat], dates: [String]) {
        var views: [String: AnyObject] = [:]
        
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        // Data Arrays
        let data = emotions
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
        
        for analysis in emotions {
            total += analysis
        }
        
        
        let average = total/CGFloat(emotions.count)
        print(emotions.count)
        
        if emotions.reversed()[0] > average {
            print(emotions.reversed()[0])
            trendLabel.text = "Looks like you're feeling good! Keep it up!"
            trendLabel.textColor = UIColor(red: 20.0/255.0, green: 125.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        } else {
            print(emotions.reversed()[0])
            trendLabel.text = "You're a bit below your expected emotion rating. Check out the Insights page for some tips!"
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
        
        if yValues[0] == 8 {
            label.text = "Emotion Displayed: Happiness"
        }
        else if yValues[0] == 7 {
            label.text = "Emotion Displayed: Surprise"
        }
        else if yValues[0] == 6 {
            label.text = "Emotion Displayed: Neutral"
        }
        else if yValues[0] == 5 {
            label.text = "Emotion Displayed: Disgust"
        }
        else if yValues[0] == 4 {
            label.text = "Emotion Displayed: Contempt"
        }
        else if yValues[0] == 3 {
            label.text = "Emotion Displayed: Anger"
        }
        else if yValues[0] == 2 {
            label.text = "Emotion Displayed: Sadness"
        }
        else if yValues[0] == 1 {
            label.text = "Emotion Displayed: Fear"
        }
        
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
