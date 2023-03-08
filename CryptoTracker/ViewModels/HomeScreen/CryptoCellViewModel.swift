/*
 CryptoCellViewModel.swift
 
 The ViewModel for CryptoCollectionCell.
 
 Created by Cristina Dobson
 */


import UIKit


struct CryptoCellViewModel: Equatable {
  
  
  // MARK: - Properties
  
  let symbol: String?
  let price24h: Double?
  let volume24h: Double?
  let lastTradePrice: Double?
  
  
  // MARK: - Helper Methods
  
  // Get the % change from the price of the last trade.
  func getPricePercentageChangeString() -> String {
    return StringHelper.getPercentageChange(for: price24h ?? 0, from: lastTradePrice ?? 0)
  }
  
  // Get the substring with the crypto currency name only.
  func getCryptoNameString() -> String? {
    return symbol?.getCryptoNameString()
  }
  
  // Get the price string in currency format
  func getPriceString() -> String {
    return StringHelper.getPriceString(from: lastTradePrice, and: symbol)
  }
  
}
