//
//  ImageProcess.swift
//  ImageChart
//
//  Created by Van Luu on 24/09/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import Foundation
import UIKit

class ImageProcess {
  
  static let image1 = drawImage1("superman")
  static let image2 = drawImage1("flash")
  static let image3 = drawImage1("batman")
  static let image4 = drawImage1("bane")
  
  fileprivate static func drawImage1(_ name: String = "superman") -> UIImage {
    let imageRect = CGRect(x: 0, y: 0, width: 600, height: 600)
    UIGraphicsBeginImageContext(imageRect.size)
//    let context = UIGraphicsGetCurrentContext()!
//    context.translateBy(x: 0, y: 600.0)
//    context.scaleBy(x: 1.0, y: -1.0)
    
    let image = UIImage(named: name)!
    
    image.draw(in: imageRect, blendMode: .color, alpha: 1.0)
    
    let returnImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return returnImage!
  }
}
