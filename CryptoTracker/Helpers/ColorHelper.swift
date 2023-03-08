//
//  ColorHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import UIKit


extension UIColor {
  
  static let backgroundBlue = UIColor(red: 10/255, green: 2/255, blue: 118/255, alpha: 1)
  
  static let backgroundPurple = UIColor(red: 93/255, green: 1/255, blue: 152/255, alpha: 1)
  
  static let darkestGray = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
  
  static let darkestGrayAlpha = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
  
}


struct ColorHelper {
  
  static func getPercentageLabelColor(for amount: String) -> UIColor {
    return amount.contains("-") ? .red : .green
  }
  
}







