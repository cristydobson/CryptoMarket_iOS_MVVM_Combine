//
//  PriceTableViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import Foundation
import Combine

enum PriceType {
  case ask, bid
}

class PriceTableViewModel {
  

  // MARK: - Properties
  
  var reloadTableView: (() -> Void)?
  var priceType: PriceType = .ask
  
  var priceCellViewModels: [PriceCellViewModel] = [] {
    didSet {
      reloadTableView?()
    }
  }
  
  
  // MARK: - Prepare Data To Reload TableView
  
  func setupViewModel(with array: [CryptoPrice], for pricesType: PriceType) {
    priceType = pricesType
    priceCellViewModels = createCellViewModels(from: array)
  }
  
  // Create PriceCellViewModels
  func createCellViewModels(from resultsArray: [CryptoPrice]) -> [PriceCellViewModel] {
    
    var viewModels: [PriceCellViewModel] = []
    
    for result in resultsArray {
      let cellViewModel = buildCellModel(from: result)
      viewModels.append(cellViewModel)
    }
    return viewModels
  }
  
  // Build a CellViewModel
  func buildCellModel(from market: CryptoPrice) -> PriceCellViewModel {
    return PriceCellViewModel(price: market.px,
                              amount: market.qty,
                              priceType: priceType)
  }
  
  /*
   Create and return a CryptoCellViewModel
   for the current IndexPath
   */
  func getCellViewModel(at indexPath: IndexPath) -> PriceCellViewModel {
    return priceCellViewModels[indexPath.row]
  }

  
}
