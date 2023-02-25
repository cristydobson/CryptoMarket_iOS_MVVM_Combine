//
//  StringHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import Foundation

struct StringHelper {
  
  // Get 24h Price percentage change
  static func getPricePercentageChange(_ price: Double, from lastPrice: Double) -> String {
    guard price > 0 else { return "0.00%" }
    let priceChange = price.getPercentageChange(from: lastPrice)
    return priceChange != 0 ? "\(priceChange.rounded(to: 2))%" : "0.00%"
  }
  
  
}
