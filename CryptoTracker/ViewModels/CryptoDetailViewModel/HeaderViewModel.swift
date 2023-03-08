/*
 HeaderViewModel.swift
 
 The ViewModel for HeaderView.
 
 Created by Cristina Dobson
 */


import Foundation
import UIKit


struct HeaderViewModel: Equatable {
  
  
  // MARK: - Properties
  
  let name: String?
  let price: Double?
  let lastTradePrice: Double?
  
  
  // MARK: - Methods
  
  // Get the icon for the current crypto currency
  func getImage() -> UIImage? {
    let coinName = name?.getCryptoNameString()
    return ImageHelper.getCryptoIcon(for: coinName)
  }
  
  // Get the price string in currency format
  func getPriceString() -> String {
    return StringHelper.getPriceString(from: lastTradePrice, and: name)
  }
  
  // Get the % change from the price of the last trade.
  func getPricePercentageChangeString() -> String {
    return StringHelper.getPercentageChange(for: price ?? 0, from: lastTradePrice ?? 0)
  }
  
}

