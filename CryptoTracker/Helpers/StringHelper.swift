/*
 StringHelper.swift
 
 Created by Cristina Dobson
 */


import Foundation


// MARK: - String Extension

extension String {
  
  /*
   Check if the currency belongs to
   the list of common currencies
   */
  var isCryptoCurrency: Bool {
    return self != "" ? !Locale.commonISOCurrencyCodes.contains(self) : false
  }
  
  // Get the currency substring
  func getCurrencyString() -> String {
    guard self.count > 0 else { return "" }
    guard self.contains("-") else { return "" }
    return String(self[
      (self.range(of: "-"))!.upperBound...
    ])
  }
  
  // Get the name substring
  func getCryptoNameString() -> String? {
    return self.components(separatedBy: "-").first
  }
  
}


// MARK: - String Helper

struct StringHelper {
  
  // Get 24h Price percentage change string.
  static func getPercentageChange(for price: Double, from lastPrice: Double) -> String {
    
    guard price > 0 else { return "0.00%" }
    let priceChange = price.getPercentageChange(from: lastPrice)
    let priceString = priceChange != 0 ? "\(priceChange.rounded(to: 2))%" : "0.00%"
    return priceChange >= 0 ? "+" + priceString : priceString
  }
  
  // Get the string from a Double with a given character count.
  static func getString(for double: Double, withCharacter count: Int) -> String {
    var string = "\(double)"
    while string.count < count {
      string.append("0")
    }
    return String(string.prefix(count))
  }
  
  // Get the Price string in a currency format.
  static func getPriceString(from price: Double?, and currency: String?) -> String {
    
    guard let currency = currency else {
      return "0.00"
    }
    
    let currencyString = currency.getCurrencyString()
    
    if let newPrice = price {
      return currencyString.isCryptoCurrency ?
      "\(newPrice) " + currencyString :
      newPrice.toCurrencyFormat(with: currencyString)
    }
    
    return (0.00).toCurrencyFormat(with: currencyString)
  }
  
}

