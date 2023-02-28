//
//  ColorHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import UIKit


extension UIColor {
  
  static let backgroundBlue = UIColor(red: 10/255, green: 2/255, blue: 118/255, alpha: 1)
  
  static let backgroundDarkBlue = UIColor(red: 5/255, green: 0/255, blue: 70/255, alpha: 1)
  
}


extension UIView {
  
  func addGradientBackground() {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [
      UIColor.black.cgColor,
      UIColor.backgroundDarkBlue.cgColor,
      UIColor.backgroundBlue.cgColor
    ]
    gradient.locations = [0.45, 0.90, 1]
    layer.addSublayer(gradient)
  }
  
}




