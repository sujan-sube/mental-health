//
//  GraphViewController.swift
//  OpenMind
//
//  Created by Aly Haji on 2017-03-11.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import QuartzCore
import HealthKit

class GraphViewController: UIViewController, LineChartDelegate {
    
    let healthStore = HKHealthStore()
    
    var label = UILabel()
    var lineChart: LineChart!
    var stepsArray = [Double]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAvailability()
        getStepCount(sender: self)
//        
//        let gradient: CAGradientLayer = CAGradientLayer()
//        
//        gradient.colors = [UIColor(red: 177.0/255.0, green: 222.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor, UIColor(red: 75.0/255.0, green: 176.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
//        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        
//        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func checkAvailability() {
        
        
        if HKHealthStore.isHealthDataAvailable() {
            
            print("Health Data is Available")
            
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))
            
            healthStore.requestAuthorization(toShare: nil, read: stepsCount as? Set<HKObjectType>, completion: { (Success, Error) in
                self.getStepCount(sender: self)
            })
        }
            
        else {
            print("Health data NOT available")
        }
    }
    
    func recentSteps(completion: @escaping (Double, [Double], NSError?) -> ()) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let date = Date()
        let calendar = Calendar.current
        let curryear = calendar.component(.year, from: date)
        let currmonth = calendar.component(.month, from: date)
        let currday = calendar.component(.day, from: date)
        let last = DateComponents(calendar: nil,
                                  timeZone: nil,
                                  era: nil,
                                  year: curryear,
                                  month: currmonth,
                                  day: currday-5,
                                  hour: nil,
                                  minute: nil,
                                  second: nil,
                                  nanosecond: nil,
                                  weekday: nil,
                                  weekdayOrdinal: nil,
                                  quarter: nil,
                                  weekOfMonth: nil,
                                  weekOfYear: nil,
                                  yearForWeekOfYear: nil)
        
        let dates = calendar.date(from: last)!
        
        let predicate = HKQuery.predicateForSamples(withStart: dates, end: Date(), options: [])
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
            query, results, error in
            var steps: Double = 0
            var allSteps = [Double]()
            if let myResults = results {
                for result in myResults as! [HKQuantitySample] {
                    print(myResults)
                    steps += result.quantity.doubleValue(for: HKUnit.count())
                    allSteps.append(result.quantity.doubleValue(for: HKUnit.count()))
                }
            }
            completion(steps, allSteps, error as NSError?)
            
        }
        healthStore.execute(query)
    }
    
    @IBAction func getStepCount(sender: AnyObject) {
        recentSteps() { steps, allSteps, error in
            DispatchQueue.main.sync {
                var avgStep: Double = 0
                avgStep = steps/7
                var converted = self.convertSteps(steps: allSteps)
                self.drawGraph(steps: converted)
                
                
            }
            
        };
    }
    
    func convertSteps(steps: [Double]) -> [CGFloat] {
        var converted = [CGFloat]()
        for step in steps {
            converted.append(CGFloat(step))
        }
        return converted
    }
    
    func drawGraph(steps: [CGFloat]) {
        var views: [String: AnyObject] = [:]
        
        label.text = "..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        // Data Arrays
        let data = steps
//        let data2: [CGFloat] = [1, 3, 5, 13, 17, 20]
        
        
        
        // simple line with custom x axis labels
        let xLabels: [String] = [findDate(x: 5), findDate(x: 4), findDate(x: 3), findDate(x: 2), findDate(x: 1), findDate(x: 0)]
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 5
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
        
    }
    
    func findDate(x: Int) -> String {
        let date = Date()
        let calendar = Calendar.current
        let curryear = calendar.component(.year, from: date)
        let currmonth = calendar.component(.month, from: date)
        let currday = calendar.component(.day, from: date)
        let last = DateComponents(calendar: nil,
                                  timeZone: nil,
                                  era: nil,
                                  year: curryear,
                                  month: currmonth,
                                  day: currday-x,
                                  hour: nil,
                                  minute: nil,
                                  second: nil,
                                  nanosecond: nil,
                                  weekday: nil,
                                  weekdayOrdinal: nil,
                                  quarter: nil,
                                  weekOfMonth: nil,
                                  weekOfYear: nil,
                                  yearForWeekOfYear: nil)
        
        let dates = calendar.date(from: last)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let strDate = dateFormatter.string(from: dates)
        
        
        return strDate
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    /**
     * Line chart delegate method.
     */
    func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>) {
        label.text = "x: \(x)     y: \(yValues)"
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
