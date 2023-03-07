//
//  CryptoCollectionViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import Foundation
import Combine


protocol CryptoCollectionViewModelDelegate: AnyObject {
  func reloadCollectionData()
}


class CryptoCollectionViewModel {
  
  
  // MARK: - Delegate
  
  weak var delegate: CryptoCollectionViewModelDelegate?
    
  
  // MARK: - Load Data
  
  private var subscriptions = Set<AnyCancellable>()
  var cryptoDataAPI = CryptoDataLoader.shared
  
  
  // MARK: - Fetch Data
    
  var reloadCollectionView: (() -> Void)?
  
  var cryptoCellViewModels: [CryptoCellViewModel] = [] {
    didSet {
      reloadCollectionView?()
    }
  }
  
  
  // Fetch data from API
  func fetchData() {

    cryptoDataAPI.fetchCryptoMarkets(from: Endpoint.tickers.rawValue)
      .sink { [unowned self] completion in
        if case let .failure(error) = completion {
          self.handleError(error)
        }
      }
      receiveValue: { [unowned self] in
        print("FETCH DATA!!!!!!!")
        let cryptoMarkets: [CryptoMarket] = $0
        self.cryptoCellViewModels = self.createCellViewModels(from: cryptoMarkets)
      }
      .store(in: &self.subscriptions)
  }
  
  // Get CryptoCellViewModels from the data response
  func createCellViewModels(from resultsArray: [CryptoMarket]) -> [CryptoCellViewModel] {
    
    var viewModels: [CryptoCellViewModel] = []
    
    for result in resultsArray {
      let cellViewModel = buildCellModel(from: result)
      viewModels.append(cellViewModel)
    }
    
    viewModels.sort {
      $0.symbol ?? "" < $1.symbol ?? ""
    }
    
    return viewModels
  }
  
  // Build a CellViewModel
  func buildCellModel(from market: CryptoMarket) -> CryptoCellViewModel {
    return CryptoCellViewModel(symbol: market.symbol,
                               price24h: market.price_24h,
                               volume24h: market.volume_24h,
                               lastTradePrice: market.last_trade_price)
  }
  
  /*
   Create and return a CryptoCellViewModel
   for the current IndexPath
   */
  func getCellViewModel(at indexPath: IndexPath) -> CryptoCellViewModel {
    return cryptoCellViewModels[indexPath.row]
  }
  
  
  // MARK: - Handle errors
  func handleError(_ apiError: CryptoDataAPIError) {
    print("ERROR: \(apiError.localizedDescription)!!!!!")
  }
  
  
  // MARK: - Timer
  
  private var timer: AnyCancellable?
  
  func startTimer() {
    timer = Timer
      .publish(every: 10, on: .main, in: .common)
      .autoconnect()
      .sink { _ in
        self.delegate?.reloadCollectionData()
      }
  }
  
  func cancelTimer() {
    timer?.cancel()
  }
  
  
}
