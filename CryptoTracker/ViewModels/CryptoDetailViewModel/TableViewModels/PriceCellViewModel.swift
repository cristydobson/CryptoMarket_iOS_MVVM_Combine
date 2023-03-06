//
//  PricesTableCellViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import UIKit

struct PriceCellViewModel: Equatable {
  
  
  // MARK: - Properties
  
  let price: Double?
  let amount: Double?
  let priceType: PriceType
  
  
  // MARK: - Methods
  
  func getPriceString() -> String {
    return StringHelper.getString(for: price!,
                                  withCharacter: 8)
  }
  
  func getPriceLabelColor() -> UIColor {
    return priceType == .ask ? UIColor.red : UIColor.green
  }
  
  func getAmountString() -> String {
    return StringHelper.getString(for: amount!, withCharacter: 7)
  }
  
}
