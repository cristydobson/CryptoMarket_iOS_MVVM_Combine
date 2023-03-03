//
//  CryptoDetailViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import Foundation
import Combine


protocol CryptoDetailViewModelDelegate: AnyObject {
  func reloadTableViewData()
}


class CryptoDetailViewModel {
  
  
  // MARK: - Delegates
  weak var delegate: CryptoDetailViewModelDelegate?
  
  
  // MARK: - Header View
  
  var headerViewModel: HeaderViewModel?
  var cryptoSymbol = ""

  
  // MARK: - Load Data
  
  private var subscriptions = Set<AnyCancellable>()
  var cryptoDataAPI = CryptoDataLoader.shared
  
  
  // MARK: - Init
  
  init() {
    initTimer()
  }

  
  // MARK: - Fetch Data
  
  var reloadTableViews: (() -> Void)?
  var noStatsAlert: (() -> Void)?
  
  var cryptoMarket: CryptoMarket! {
    didSet {
      reloadTableViews?()
    }
  }
  
  var asks: [CryptoPrice]?
  var bids: [CryptoPrice]?
  
  
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
      let market: CryptoMarket = $0
      self.checkForStats(for: market)
    }
    .store(in: &self.subscriptions)
  }
  
  
  // MARK: - Handle errors
  func handleError(_ apiError: CryptoDataAPIError) {
    print("ERROR: \(apiError.localizedDescription)!!!!!")
  }
  
  
  func checkForStats(for market: CryptoMarket) {
    if let asksArray = market.asks, asksArray.count > 0,
       let bidsArray = market.bids, bidsArray.count > 0
    {
      asks = asksArray
      bids = bidsArray
      
      headerViewModel = HeaderViewModel(name: cryptoSymbol,
                                        price: asksArray.first?.px)
      
      cryptoMarket = market
      
    }
    else {
      cancellable?.cancel()
      noStatsAlert?()
    }
  }
  
  
  // MARK: - Timer
  
  private var cancellable: AnyCancellable?
  
  func initTimer() {
    cancellable = Timer
      .publish(every: 10, on: .main, in: .common)
      .autoconnect()
      .sink { _ in
        self.delegate?.reloadTableViewData()
      }
  }
  
  
}


