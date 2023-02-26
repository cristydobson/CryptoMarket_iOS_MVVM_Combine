//
//  CryptoDetailViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import Foundation
import Combine


class CryptoDetailViewModel {
  
  
  // MARK: - Load Data
  
  private var subscriptions = Set<AnyCancellable>()
  var cryptoDataAPI = CryptoDataLoader.shared

  
  // MARK: - Fetch Data
  
  var reloadTableViews: (() -> Void)?
  
  var cryptoMarkets: [CryptoMarket] = [] {
    didSet {
      reloadTableViews?()
    }
  }
  
  // TODO: - Refactor this fetch data from all classes into a single class
  // Fetch data from API
  func fetchData(with symbol: String) {
    
    let queryString = Endpoint.l2.rawValue + symbol
    
    cryptoDataAPI.fetchCryptoMarkets(from: queryString)
      .sink { [unowned self] completion in
        if case let .failure(error) = completion {
          self.handleError(error)
        }
      }
    receiveValue: { [unowned self] in
      self.cryptoMarkets = $0
    }
    .store(in: &self.subscriptions)
  }
  
  
  // MARK: - Handle errors
  func handleError(_ apiError: CryptoDataAPIError) {
    print("ERROR: \(apiError.localizedDescription)!!!!!")
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
}


