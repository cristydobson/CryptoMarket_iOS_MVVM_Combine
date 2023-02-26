//
//  CryptoDetailViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import Foundation
import Combine


class CryptoDetailViewModel {
  
  
  
  
  
  // Fetch data from API
//  func fetchData() {
//
//    cryptoDataAPI.fetchCryptoMarkets(from: Endpoint.tickers.rawValue)
//      .sink { [unowned self] completion in
//        if case let .failure(error) = completion {
//          self.handleError(error)
//        }
//      }
//  receiveValue: { [unowned self] in
//    self.createCellViewModels(from: $0)
//  }
//  .store(in: &self.subscriptions)
//  }
  
  
}




//// MARK: - Load Data
///
//private var subscriptions = Set<AnyCancellable>()
//var cryptoDataAPI = CryptoDataLoader.shared
//
//func getCryptoData() {
//  fetchData()
//}
//
//
//// MARK: - CollectionView
//
//var reloadCollectionView: (() -> Void)?
//
//var cryptoCellViewModels: [CryptoCellViewModel] = [] {
//  didSet {
//    reloadCollectionView?()
//  }
//}
//
//        // Fetch data from API
//        func fetchData() {
//
//          cryptoDataAPI.fetchCryptoMarkets(from: Endpoint.tickers.rawValue)
//            .sink { [unowned self] completion in
//              if case let .failure(error) = completion {
//                self.handleError(error)
//              }
//            }
//        receiveValue: { [unowned self] in
//          self.createCellViewModels(from: $0)
//        }
//        .store(in: &self.subscriptions)
//        }


//// Get CryptoCellViewModels from the data response
//func createCellViewModels(from resultsArray: [CryptoMarket]) {
//
//  var viewModels: [CryptoCellViewModel] = []
//
//  for result in resultsArray {
//    let cellViewModel = buildCellModel(from: result)
//    viewModels.append(cellViewModel)
//  }
//  cryptoCellViewModels = viewModels
//}
//
//// Build a CellViewModel
//func buildCellModel(from market: CryptoMarket) -> CryptoCellViewModel {
//  return CryptoCellViewModel(symbol: market.symbol,
//                             price24h: market.price_24h,
//                             volume24h: market.volume_24h,
//                             lastTradePrice: market.last_trade_price)
//}
//
///*
// Create and return a CryptoCellViewModel
// for the current IndexPath
// */
//func getCellViewModel(at indexPath: IndexPath) -> CryptoCellViewModel {
//  return cryptoCellViewModels[indexPath.row]
//}
//
//
//// MARK: - Handle errors
//func handleError(_ apiError: CryptoDataAPIError) {
//  print("ERROR: \(apiError.localizedDescription)!!!!!")
//}