//
//  DashBoardViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-18.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import SwiftCharts

class DashBoardViewController: UIViewController {
    
    fileprivate var chart: Chart? // arc
    
    let buttonBackgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    let buttonborderwidth = 0.5
    let buttonbordercolor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
    

    @IBOutlet weak var Journal: UIButton!
    @IBOutlet weak var Emotion: UIButton!
    @IBOutlet weak var Activity: UIButton!
    @IBOutlet weak var Sleep: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGraph()
        self.setupButtons()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
        
    }

    @IBAction func Journal(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupButtons() -> Void {
        self.Journal.backgroundColor = buttonBackgroundColor
        self.Emotion.backgroundColor = buttonBackgroundColor
        self.Activity.backgroundColor = buttonBackgroundColor
        self.Sleep.backgroundColor = buttonBackgroundColor
        
        self.Journal.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Journal.layer.borderColor = buttonbordercolor.cgColor
        
        self.Emotion.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Emotion.layer.borderColor = buttonbordercolor.cgColor
        
        self.Activity.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Activity.layer.borderColor = buttonbordercolor.cgColor
        
        self.Sleep.layer.borderWidth = CGFloat(buttonborderwidth)
        self.Sleep.layer.borderColor = buttonbordercolor.cgColor
        
        
        let Journalimage = UIImage(named: "PositiveEntry")
        let Emotionimage = UIImage(named: "PositiveEntry")
        let Activityimage = UIImage(named: "PositiveEntry")
        let Sleepimage = UIImage(named: "PositiveEntry")
        
        //self.Journal.imageEdgeInsets = UIEdgeInsetsMake(45, 45, 70, 45)
        //self.Journal.setImage(Journalimage, for: UIControlState.normal)
        self.Journal.setTitle("Journal", for: UIControlState.normal)
        self.Emotion.setTitle("Emotion", for: UIControlState.normal)
        self.Activity.setTitle("Activity", for: UIControlState.normal)
        self.Sleep.setTitle("Sleep", for: UIControlState.normal)
        
    }
    
    
    func setupGraph() ->Void {
        let chartPoints: [ChartPoint] = [(0, 4), (16, 4)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        
        
        let chartPoints2: [ChartPoint] = [(2, 2), (4, 4), (6, 3), (8, 5), (10,8), (12, 6), (15,5)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt($0.1))}
        
        let xValues = stride(from:0, through: 16, by: 2).map {ChartAxisValueInt($0, labelSettings: ChartLabelSettings(font: ExamplesDefaults.labelFontSmall, fontColor: UIColor.white))}
        
        let yValues = stride(from:0, through: 12, by: 2).map {ChartAxisValueInt($0, labelSettings: ChartLabelSettings(font: ExamplesDefaults.labelFontSmall, fontColor: UIColor.white))}
        
        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: 14), fontColor: UIColor.white, rotation: 0, rotationKeep: .top, shiftXOnRotation: false, textAlignment: .left)
        
        
        // create axis models with axis values and axis title
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Days of the Week", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Health Status", settings: labelSettings.defaultVertical()))
        
        let chartFrame = CGRect(x: 30,y: 0,width: 300,height: 350)
        
        let chartSettings = ChartSettings()
        chartSettings.axisStrokeWidth = 0.5
        chartSettings.top = 20
        chartSettings.trailing = 0
        chartSettings.labelsToAxisSpacingX = 10.0
        chartSettings.labelsToAxisSpacingY = 10.0
        chartSettings.axisTitleLabelsToLabelsSpacing = 30.0
        chartSettings.bottom = 10.0
        // ...
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let c1 = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.3)
        
        
        let chartArealayer = ChartPointsAreaLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, areaColor: c1, animDuration: 1, animDelay: 0, addContainerPoints: true)
        
        
        
        // create layer with line
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6), lineWidth: 3, animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        
        let lineModel2 = ChartLineModel(chartPoints: chartPoints2, lineColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6), lineWidth: 3, animDuration: 5, animDelay: 0)
        let chartPointsLineLayer2 = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel2])
        
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 12)
            circleView.animDuration = 1.5
            circleView.fillColor = UIColor.white
            circleView.borderWidth = 2
            circleView.borderColor = UIColor.blue
            circleView.animateSize = true
            return circleView
        }
        
        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints2, viewGenerator: circleViewGenerator, conflictSolver: nil, displayDelay: 0, delayBetweenItems: 0.05)
        
        
        // creates custom view for each chartpoint
        let myCustomViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let center = chartPointModel.screenLoc
            let label = UILabel(frame: CGRect(x: center.x - 20, y:  center.y - 10,width: 40,height: 20))
            label.backgroundColor = UIColor.green
            label.textAlignment = NSTextAlignment.center
            label.text = chartPointModel.chartPoint.description
            label.font = ExamplesDefaults.labelFont
            return label
        }
        
        let showCoordsTextViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let w: CGFloat = 70
            let h: CGFloat = 30
            
            let text = "(\(chartPoint.x), \(chartPoint.y))"
            let font = ExamplesDefaults.labelFont
            let x = min(screenLoc.x + 5, chart.bounds.width - 5)
            let view = UIView(frame: CGRect(x: x, y: screenLoc.y - h, width: w, height: h))
            let label = UILabel(frame: view.bounds)
            label.text = "(\(chartPoint.x), \(chartPoint.y))"
            label.font = ExamplesDefaults.labelFont
            view.addSubview(label)
            view.alpha = 0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                view.alpha = 1
            }, completion: nil)
            
            return view
        }
        
        let showCoordsLinesLayer = ChartShowCoordsLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints2)
        
        let showCoordsTextLayer = ChartPointsSingleViewLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints2, viewGenerator: showCoordsTextViewsGenerator)
        
        let touchViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let s: CGFloat = 30
            let view = HandlingView(frame: CGRect(x: screenLoc.x - s/2, y: screenLoc.y - s/2, width: s, height: s))
            view.touchHandler = {[weak showCoordsLinesLayer, weak showCoordsTextLayer, weak chartPoint, weak chart] in
                guard let chartPoint = chartPoint, let chart = chart else {return}
                showCoordsLinesLayer?.showChartPointLines(chartPoint, chart: chart)
                showCoordsTextLayer?.showView(chartPoint: chartPoint, chart: chart)
            }
            return view
        }
        
        let touchlayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints2, viewGenerator: touchViewsGenerator)
        
        // create layer that uses the view generator
        let myCustomViewLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: myCustomViewGenerator, displayDelay: 0, delayBetweenItems: 0.05)
        
        
        // create layer with guidelines
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                //guidelinesLayer,
                chartArealayer,
                //chartArealayer2,
                chartPointsLineLayer,
                chartPointsLineLayer2,
                chartPointsCircleLayer,
                showCoordsLinesLayer,
                showCoordsTextLayer,
                touchlayer
                //myCustomViewLayer
            ]
        )
        
        self.view.addSubview(chart.view)
        self.chart = chart
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

