//
//  PieChartView.swift
//  ImageChart
//
//  Created by Van Luu on 25/09/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import Foundation
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

class PieChartView: UIView {
  
  var startAngle: CGFloat = 0 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func pieChart(_ pieces:[(UIBezierPath, UIImage)], viewRect:CGRect) {
    let context = UIGraphicsGetCurrentContext()
    for p in pieces {
      let layer = CAShapeLayer()
      layer.path = p.0.cgPath
      let fillImage = UIColor(patternImage: p.1).cgColor
      layer.fillColor = fillImage
      layer.strokeColor = UIColor.white.cgColor
      
      layer.render(in: context!)
    }
  }
  
  func draw() {
    let img1 = ImageProcess.image1
    let img2 = ImageProcess.image2
    let img3 = ImageProcess.image3
    let rectSize = CGRect(x: 0, y: 0, width: 400, height: 400)
    let centrePointOfChart = CGPoint(x: rectSize.midX, y: rectSize.midY)
    let radius:CGFloat = 200
    let piePieces = [(UIBezierPath(circleSegmentCenter: centrePointOfChart, radius: radius, startAngle: startAngle, endAngle: startAngle + 50),img1), (UIBezierPath(circleSegmentCenter: centrePointOfChart, radius: radius, startAngle: startAngle + 50, endAngle: startAngle + 200),img2), (UIBezierPath(circleSegmentCenter: centrePointOfChart, radius: radius, startAngle: startAngle + 200, endAngle: startAngle + 360),img3)]
    pieChart(piePieces, viewRect: CGRect(x: 0, y: 0, width: 400, height: 400))
  }
  
  override func draw(_ rect: CGRect) {
    draw()
  }
}
