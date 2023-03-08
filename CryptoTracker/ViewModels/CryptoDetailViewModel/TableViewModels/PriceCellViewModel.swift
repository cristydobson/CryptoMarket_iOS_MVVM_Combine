/*
 PricesTableCellViewModel.swift
 
 The ViewModel for PricesTableCell.
 
 Created by Cristina Dobson
 */


import UIKit


struct PriceCellViewModel: Equatable {
  
  
  // MARK: - Properties
  
  let price: Double?
  let amount: Double?
  let priceType: PriceType
  
  
  // MARK: - Methods
  
  // Get the price string 
  func getPriceString() -> String {
    return StringHelper.getString(
      for: price!, withCharacter: 8)
  }
  
  // Get the label color based on PriceType
  func getPriceLabelColor() -> UIColor {
    return priceType == .ask ? UIColor.red : UIColor.green
  }
  
  // Get the amount string
  func getAmountString() -> String {
    return StringHelper.getString(
      for: amount!, withCharacter: 7)
  }
  
}
