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

  
  // MARK: - Load Data
  
  private var subscriptions = Set<AnyCancellable>()
  var cryptoDataAPI = CryptoDataLoader.shared
  
  
  // MARK: - Init
  
  init() {
    initTimer()
  }
  
  
  // MARK: - Fetch Data For Header
  
  var reloadHeader: (() -> Void)?
  
  var headerViewModel: HeaderViewModel! {
    didSet {
      reloadHeader?()
    }
  }
  
  // Fetch data from API
  func fetchHeaderData(with symbol: String) {
    
    let queryString = Endpoint.singleTicker.rawValue + symbol
    
    cryptoDataAPI.fetchCryptoMarkets(from: queryString)
      .sink { [unowned self] completion in
        if case let .failure(error) = completion {
          self.handleError(error)
        }
      }
    receiveValue: { [unowned self] in
      let market: CryptoMarket = $0
      self.headerViewModel = self.createHeaderViewModel(from: market)
    }
    .store(in: &self.subscriptions)
  }
  
  func createHeaderViewModel(from market: CryptoMarket) -> HeaderViewModel {
    return HeaderViewModel(name: market.symbol ?? "",
                                      price: market.price_24h ?? 0,
                                      lastTradePrice: market.last_trade_price ?? 0)
  }
  

  
  // MARK: - Fetch Data For TableViews
  
  var reloadTableViews: (() -> Void)?
  var noStatsAlert: (() -> Void)?
  
  var cryptoMarket: CryptoMarket! {
    didSet {
      reloadTableViews?()
    }
  }
  
  var asks: [CryptoPrice]?
  var bids: [CryptoPrice]?
  
  
  // Fetch TableViews data from API
  func fetchTableViewData(with symbol: String) {
    
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
    
    let asksArray = market.asks ?? []
    let bidsArray = market.bids ?? []
    
    if asksArray.count > 0 || bidsArray.count > 0
    {
      fetchHeaderData(with: market.symbol!)
      
      asks = asksArray
      bids = bidsArray
      
      cryptoMarket = market
      
    }
    else {
      noStatsAlert?()
    }
  }
  
  
  // MARK: - Timer
  
  private var timer: AnyCancellable?
  
  func initTimer() {
    timer = Timer
      .publish(every: 10, on: .main, in: .common)
      .autoconnect()
      .sink { _ in
        self.delegate?.reloadTableViewData()
    }
  }
  
  func cancelTimer() {
    timer?.cancel()
  }
  
}


