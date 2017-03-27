//
//  EmotionIndividualEntryViewController.swift
//  OpenMind
//
//  Created by Rehan Anwar on 2017-03-18.
//  Copyright © 2017 Aly Haji. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import PieCharts



class EmotionImageIndividualEntryViewController: UIViewController, PieChartDelegate {
    
    
    var date : String?
    var time : String?
    var DatabaseDate : String?
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var chartView: PieChart!
    
    @IBOutlet weak var VideoView: UIView!
    let red = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
    let green = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
    let blue = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
    
    var globalplayer = AVPlayer()
    var playerLayer = AVPlayerLayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DateLabel.text = "\(self.date!) at  \(self.time!)"
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        globalplayer = AVPlayer(url: videoURL!)
        //        self.globalplayer = player
        playerLayer = AVPlayerLayer(player: globalplayer)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.frame = self.VideoView.frame
        self.view.layer.addSublayer(playerLayer)
        playerLayer.borderColor = UIColor.black.cgColor
        playerLayer.borderWidth = 1.0
        //addtopLeftViewConstraints()
        
        
        self.globalplayer.play()
        
        chartView.layers = [createTextWithLinesLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        self.globalplayer.pause()
        self.globalplayer.replaceCurrentItem(with: nil)
        self.playerLayer.removeFromSuperlayer()
        //        globalplayer = nil
    }
    
    fileprivate static let alpha: CGFloat = 0.5
    let colors = [
        UIColor.green.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.blue.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.darkGray.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.magenta.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.brown.withAlphaComponent(alpha),
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.gray.withAlphaComponent(alpha),
        ]
    fileprivate var currentColorIndex = 0
    
    
    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    // MARK: - Models
    
    fileprivate func createModels() -> [PieSliceModel] {
        
        let models = [
            PieSliceModel(value: 60, color: colors[0]),
            PieSliceModel(value: 20, color: colors[1]),
            PieSliceModel(value: 10, color: colors[2]),
            PieSliceModel(value: 10, color: colors[3])
        ]
        
        
        currentColorIndex = models.count
        return models
    }
    
    
    // MARK: - Layers
    
    fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
        
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 30
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 12)
        //
        //        let formatter = NumberFormatter()
        //        formatter.maximumFractionDigits = 1
        //        textLayerSettings.label.textGenerator = {slice in
        //
        //
        //            //return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        //        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
        let lineTextLayer = PieLineTextLayer()
        var lineTextLayerSettings = PieLineTextLayerSettings()
        lineTextLayerSettings.lineColor = UIColor.white
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        lineTextLayerSettings.label.textGenerator =
            
            {slice in
                
                if slice.data.model.color == self.colors[0] {
                    return "Happy"
                }
                else if slice.data.model.color == self.colors[1]{
                    return "Neutral"
                }
                else if slice.data.model.color == self.colors[2]{
                    return "Sad"
                }
                else{
                    return "Angry"
                }
                
                //return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
        }
        
        lineTextLayer.settings = lineTextLayerSettings
        return lineTextLayer
    }
    
    @IBAction func onPlusTap(sender: UIButton) {
        let newModel = PieSliceModel(value: 4 * Double(CGFloat.random()), color: colors[currentColorIndex])
        chartView.insertSlice(index: 0, model: newModel)
        currentColorIndex = (currentColorIndex + 1) % colors.count
        if currentColorIndex == 2 {currentColorIndex += 1} // avoid same contiguous color
    }
    
}

//extension CGFloat {
//    static func random() -> CGFloat {
//        return CGFloat(arc4random()) / CGFloat(UInt32.max)
//    }
//}
//
//extension UIColor {
//    static func randomColor() -> UIColor {
//        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
//    }
//}
