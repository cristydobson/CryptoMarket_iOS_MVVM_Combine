//
//  DoubleExtensions.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import Foundation


extension Double {
  
  func getPercentageChange(from latestPrice: Double) -> Double {
    return ((latestPrice - self) / self) * 100
  }
  
  func rounded(to decimalPlaces: Int) -> Double {
    let divisor = pow(10.0, Double(decimalPlaces))
    return (self * divisor).rounded() / divisor
  }
  
}
