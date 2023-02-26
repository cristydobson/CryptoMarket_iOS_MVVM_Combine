//
//  PricesTableCellViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import UIKit

struct PriceCellViewModel {
  
  
  // MARK: - Properties
  
  let price: Double?
  let amount: Double?
  let priceType: PriceType
  
  
  // MARK: - Methods
  
  func getPriceLabelColor() -> UIColor {
    return priceType == .ask ? UIColor.red : UIColor.green
  }
  
}
