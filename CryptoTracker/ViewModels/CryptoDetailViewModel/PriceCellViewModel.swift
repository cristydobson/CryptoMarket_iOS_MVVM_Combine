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
  let isAsk: Bool
  
  
  // MARK: - Methods
  
  func getPriceLabelColor() -> UIColor {
    return isAsk ? UIColor.red : UIColor.green
  }
  
}
