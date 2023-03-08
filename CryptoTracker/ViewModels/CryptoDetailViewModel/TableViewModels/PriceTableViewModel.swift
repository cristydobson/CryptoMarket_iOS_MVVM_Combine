/*
 PriceTableViewModel.swift
 
 The ViewModel for PricesTableView.
 
 Create the TableCellViewModels with the
 ASK and BID arrays data.
 
 Created by Cristina Dobson
 */


import Foundation
import Combine


// Type of data array ASK or BID
enum PriceType {
  case ask, bid
}


class PriceTableViewModel {
  

  // MARK: - Properties
  
  var priceType: PriceType = .ask

  var priceCellViewModels: [PriceCellViewModel] = []
  
  
  // MARK: - Prepare Data To Load The TableView
  
  func setupViewModel(with array: [CryptoPrice], for pricesType: PriceType) {
    priceType = pricesType
    priceCellViewModels = createCellViewModels(from: array)
  }
  
  // Create the CellViewModels
  func createCellViewModels(from resultsArray: [CryptoPrice]) -> [PriceCellViewModel] {
    
    var viewModels: [PriceCellViewModel] = []
    
    for result in resultsArray {
      let cellViewModel = buildCellModel(from: result)
      viewModels.append(cellViewModel)
    }
    return viewModels
  }
  
  // Build a single CellViewModel
  func buildCellModel(from market: CryptoPrice) -> PriceCellViewModel {
    return PriceCellViewModel(
      price: market.px, amount: market.qty,
      priceType: priceType)
  }
  
  // Return a CellViewModel for the current IndexPath
  func getCellViewModel(at indexPath: IndexPath) -> PriceCellViewModel {
    return priceCellViewModels[indexPath.row]
  }

}
