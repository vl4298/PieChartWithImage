//
//  ViewController.swift
//  ImageChart
//
//  Created by Van Luu on 24/09/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import UIKit


extension CGFloat {
  func radians() -> CGFloat {
    let b = CGFloat(M_PI) * (self/180)
    return b
  }
}

extension UIBezierPath {
  convenience init(circleSegmentCenter center:CGPoint, radius:CGFloat, startAngle:CGFloat, endAngle:CGFloat)
  {
    self.init()
    self.move(to: CGPoint(x: center.x, y: center.y))
    self.addArc(withCenter: center, radius:radius, startAngle:startAngle.radians(), endAngle: endAngle.radians(), clockwise:true)
    self.close()
  }
}



func pieChart(_ pieces:[(UIBezierPath, UIImage)], viewRect:CGRect) -> UIView {
  var layers = [CAShapeLayer]()
  for p in pieces {
    let layer = CAShapeLayer()
    layer.path = p.0.cgPath
    let fillImage = UIColor(patternImage: p.1).cgColor
    layer.fillColor = fillImage
    layer.strokeColor = UIColor.white.cgColor
    layers.append(layer)
  }
  let view = UIView(frame: viewRect)
  for l in layers {
    
    view.layer.addSublayer(l)
    
    
  }
  return view
}

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
  
  var chartView: UIView!
  var startAngle: CGFloat = 0
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    chartView = draw()
    view.addSubview(chartView)
  }
  
  func draw() -> UIView {
    let img1 = ImageProcess.image1
    let img2 = ImageProcess.image2
    let img3 = ImageProcess.image3
    let rectSize = CGRect(x: 0, y: 0, width: 400, height: 400)
    let centrePointOfChart = CGPoint(x: rectSize.midX, y: rectSize.midY)
    let radius:CGFloat = 200
    let piePieces = [(UIBezierPath(circleSegmentCenter: centrePointOfChart, radius: radius, startAngle: startAngle, endAngle: startAngle + 50),img1), (UIBezierPath(circleSegmentCenter: centrePointOfChart, radius: radius, startAngle: startAngle + 50, endAngle: startAngle + 200),img2), (UIBezierPath(circleSegmentCenter: centrePointOfChart, radius: radius, startAngle: startAngle + 200, endAngle: startAngle + 360),img3)]
    return pieChart(piePieces, viewRect: CGRect(x: 0, y: 0, width: 400, height: 400))
  }
  
  var preDegree = 0
  @IBAction func rotate(sender: UIButton) {
    chartView.removeFromSuperview()
    startAngle += 10
    chartView = draw()
    view.addSubview(chartView)
  }


}

