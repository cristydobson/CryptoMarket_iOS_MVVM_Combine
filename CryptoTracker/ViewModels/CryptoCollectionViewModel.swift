//
//  CryptoCollectionViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import Foundation

class CryptoCollectionViewModel {
  
  
 
  
  // MARK: - Load Data
 
  func getCryptoData() {
    fetchData()
  }
  
  
  // MARK: - CollectionView
  
  let tempNames = ["Bitcoin", "Etherium", "DogeCoin", "Tether", "Solana", "Binance"]
  
  var reloadCollectionView: (() -> Void)?
  
  var cryptoCellViewModels: [CryptoCellViewModel] = [] {
    didSet {
      reloadCollectionView?()
    }
  }
  
  // Create the CellViewModels
  func fetchData() {
    
    var viewModels: [CryptoCellViewModel] = []
    
    for name in tempNames {
      viewModels.append(buildCellModel(with: name))
    }
    
    cryptoCellViewModels = viewModels
  }
  
  // Build the CellViewModels
  func buildCellModel(with name: String) -> CryptoCellViewModel {
    return CryptoCellViewModel(name: name)
  }
  
  /*
   Create and return a CryptoCellViewModel
   for the current IndexPath
   */
  func getCellViewModel(at indexPath: IndexPath) -> CryptoCellViewModel {
    return cryptoCellViewModels[indexPath.row]
  }
  
  
}
