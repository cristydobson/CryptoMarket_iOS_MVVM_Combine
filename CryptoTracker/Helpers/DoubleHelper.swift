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
  
  // Format a double to a currency format
  func toCurrencyFormat(with code: String) -> String {
   
    if code != "" {
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencyCode = code
      formatter.maximumFractionDigits = 2
      return formatter.string(from: NSNumber(value: self))!
    }
    return "0.00"
  }
  
}

