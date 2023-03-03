//
//  HeaderViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 3/1/23.
//

import Foundation
import UIKit


struct HeaderViewModel {
  
  
  // MARK: - Properties
  
  let name: String?
  let price: Double?
  let lastTradePrice: Double?
  
  
  // MARK: - Methods
  
  func getImage() -> UIImage {
    let coinName = name?.getCryptoNameString()
    return ImageHelper.getCryptoIcon(for: coinName)!
  }
  
  func getPriceString() -> String {
    if let price = lastTradePrice,
       let name = name {
      return StringHelper.getPriceString(from: price, and: name)
    }
    return ""
  }
  
  func getPricePercentageChangeString() -> String {
    return StringHelper.getPercentageChange(for: price ?? 0, from: lastTradePrice ?? 0)
  }
  
}

