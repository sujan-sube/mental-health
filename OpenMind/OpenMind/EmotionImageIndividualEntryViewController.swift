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
    
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!

    
    var date : String?
    var time : String?
    var DatabaseDate : String?
    var imageurl : String?
    var expressions : [String:Any]?
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var chartView: PieChart!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    let red = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
    let green = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
    let blue = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
    
    var emotionvalues = [String:Double]()
    
    
    var anger : Double?
    var contempt : Double?
    var disgust : Double?
    var fear : Double?
    var happiness : Double?
    var neutral : Double?
    var sadness : Double?
    var surprise : Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DateLabel.text = "\(self.date!) at  \(self.time!)"
        
        self.ImageView.downloadedFrom(link: self.imageurl!)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        chartView.layers = [createTextWithLinesLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
        
        myActivityIndicator.startAnimating();

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
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
        
        
        for individualexpression in self.expressions! {
            print(individualexpression.value)
            
            var expressionvalue = Double(((individualexpression.value) as? String)!)!
            
            if (expressionvalue >= 0.99){
                expressionvalue = 0.99
            }
            if (expressionvalue <= 0.02){
                expressionvalue = 0.02
            }
            
            self.emotionvalues["\(individualexpression.key)"] = expressionvalue*100
            
        }
        
        let models = [
            PieSliceModel(value: (self.emotionvalues["happiness"])!, color: colors[0]),
            PieSliceModel(value: (self.emotionvalues["neutral"])!, color: colors[1]),
            PieSliceModel(value: (self.emotionvalues["sadness"])!, color: colors[2]),
            PieSliceModel(value: (self.emotionvalues["anger"])!, color: colors[3])
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
                    return "Anger"
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





extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image

            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
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
