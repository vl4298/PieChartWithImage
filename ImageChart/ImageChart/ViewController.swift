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
  var displayLink: CADisplayLink?
  var radianPerSecond: Double = 0
  var lastTimeTick: TimeInterval! = 0
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    chartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    view.addSubview(chartView)

    let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(runGesture(gesture:)))
    chartView.addGestureRecognizer(dragGesture)
  }
  
  
  
  func runGesture(gesture: UIPanGestureRecognizer) {
    
    switch gesture.state {
    case .began:
      if displayLink == nil {
        displayLink = CADisplayLink(target: self, selector: #selector(updateChartView))
        displayLink!.preferredFramesPerSecond = 60
        displayLink!.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
      }
    case .cancelled, .ended:
      if displayLink != nil {
        displayLink?.invalidate()
        displayLink = nil
      }
    default:
      radianPerSecond = Double(gesture.velocity(in: self.chartView!).y)/2

    }
  }
  
  var finalRadian: CGFloat = 0
  @IBAction func rotate(sender: UIButton) {
//    finalRadian = chartView.startAngle + 100
    
    
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.fromValue = 0
    rotateAnimation.toValue = M_PI
    rotateAnimation.duration = 3.0
    
    chartView.layer.add(rotateAnimation, forKey: "rotate")
  }
  
  func updateChartView() {
    print("run")
    if lastTimeTick == 0 {
      lastTimeTick = displayLink!.timestamp
    }
    
    let currentTimestamp = displayLink!.timestamp
    let delta = CGFloat(radianPerSecond * (currentTimestamp - lastTimeTick))
    chartView.startAngle += delta
    lastTimeTick = currentTimestamp
    
  }


}

