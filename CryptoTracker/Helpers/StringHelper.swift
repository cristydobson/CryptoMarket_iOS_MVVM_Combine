//
//  StringHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import Foundation


extension String {
  
  var isCryptoCurrency: Bool {
    return !Locale.commonISOCurrencyCodes.contains(self)
  }
  
  func getCurrencyString() -> String {
    guard self.count > 0 else { return "" }
    guard self.contains("-") else { return self }
    return String(self[
      (self.range(of: "-"))!.upperBound...
    ])
  }
  
  func getCryptoNameString() -> String {
    return self.components(separatedBy: "-").first!
  }
  
}


struct StringHelper {
  
  // Get 24h Price percentage change
  static func getPercentageChange(for price: Double, from lastPrice: Double) -> String {
    guard price > 0 else { return "0.00%" }
    let priceChange = price.getPercentageChange(from: lastPrice)
    let priceString = priceChange != 0 ? "\(priceChange.rounded(to: 2))%" : "0.00%"
    return priceChange >= 0 ? "+" + priceString : priceString
  }
  
  static func getString(for double: Double, withCharacter count: Int) -> String {
    var string = "\(double)"
    while string.count < count {
      string.append("0")
    }
    return String(string.prefix(count))
  }
  
  static func getPriceString(from price: Double, and currency: String) -> String {
    let currencyString = currency.getCurrencyString()
    return currencyString.isCryptoCurrency ?
    "\(price) " + currencyString :
    price.toCurrencyFormat(with: currencyString)
  }
  
}
