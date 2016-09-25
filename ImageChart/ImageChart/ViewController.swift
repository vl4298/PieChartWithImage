//
//  ViewController.swift
//  ImageChart
//
//  Created by Van Luu on 24/09/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import UIKit








extension Int {
  var radian: CGFloat {
    return CGFloat(Double(self) * M_PI / 180)
  }
}

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  var chartView: PieChartView!
  var startAngle: CGFloat = 0
  var displayLink: CADisplayLink!
  var radianPerSecond: Double = 5
  var lastTimeTick: TimeInterval! = 0
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    chartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    view.addSubview(chartView)
  }
  
  
  
  func draw2() -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    view.backgroundColor = UIColor.red
    return view
  }
  
  var finalRadian: CGFloat = 0
  @IBAction func rotate(sender: UIButton) {
    finalRadian = chartView.startAngle + 100
    displayLink = CADisplayLink(target: self, selector: #selector(updateChartView))
    displayLink.preferredFramesPerSecond = 1
    displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
  }
  
  func updateChartView() {
    if lastTimeTick == 0 {
      lastTimeTick = displayLink!.timestamp
    }
    
    let currentTimestamp = displayLink!.timestamp
    let delta = CGFloat(radianPerSecond * (currentTimestamp - lastTimeTick))
    print(delta)
    chartView.startAngle += delta
    lastTimeTick = currentTimestamp
    
    if chartView.startAngle >= finalRadian {
      chartView.startAngle = finalRadian
      displayLink.invalidate()
      displayLink = nil
    }
    
    
  }


}

