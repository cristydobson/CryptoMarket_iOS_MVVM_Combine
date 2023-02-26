//
//  ColorHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import UIKit


extension UIColor {
  
  static let backgroundPurple = UIColor(red: 93/255, green: 1/255, blue: 152/255, alpha: 1)
  
  static let backgroundBlue = UIColor(red: 10/255, green: 2/255, blue: 118/255, alpha: 1)
  
}


extension UIView {
  
  func addGradientBackground() {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [
      UIColor.black.cgColor,
      UIColor.backgroundBlue.cgColor,
      UIColor.backgroundPurple.cgColor
    ]
    gradient.locations = [0.39, 0.80, 1]
    layer.addSublayer(gradient)
  }
  
}




