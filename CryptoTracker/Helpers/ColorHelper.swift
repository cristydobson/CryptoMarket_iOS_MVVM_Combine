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
  
}


struct ColorHelper {
  
  static func getPercentageLabelColor(for amount: String) -> UIColor {
    return amount.contains("-") ? .red : .green
  }
  
}







