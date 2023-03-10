/*
 CryptoDetailViewModel.swift
 
 The ViewModel for CryptoDetailViewController.
 
 Fetch data for a single crypto currency
 to display on the CryptoDetailViewController.
 
 Created by Cristina Dobson
 */


import Foundation
import Combine


/*
 Tell CryptoDetailViewController to reload the displayed data
 on the table views and header when the timer is up.
 */
protocol CryptoDetailViewModelDelegate: AnyObject {
  func reloadTableViewData()
}


class CryptoDetailViewModel: ObservableObject {
  
  
  // MARK: - Properties
  weak var delegate: CryptoDetailViewModelDelegate?
  
  private var subscriptions = Set<AnyCancellable>()
  var cryptoDataAPI = CryptoDataLoader.shared
  
  
  // MARK: - Init
  
  init() {
    initTimer()
  }
  
  
  // MARK: - Fetch Data For The HeaderView
  
  // Fetch a single ticker displayed on the HeaderView
  
  @Published var headerViewModel: HeaderViewModel!
  
  // Fetch data through the API
  func fetchHeaderData(with symbol: String) {
    
    let queryString = Endpoint.singleTicker.rawValue + symbol
    
    cryptoDataAPI.fetchCryptoMarkets(from: queryString)
      .sink { [unowned self] completion in
        if case let .failure(error) = completion {
          self.handleError(error)
        }
      }
    receiveValue: { [unowned self] in
      /*
       If successful, create the HeaderViewModel
       with the brand new data.
       */
      let market: CryptoMarket = $0
      self.headerViewModel = self.createHeaderViewModel(from: market)
    }
    .store(in: &self.subscriptions)
  }
  
  // Create the HeaderViewModel with the newly fetched data
  func createHeaderViewModel(from market: CryptoMarket) -> HeaderViewModel {
    return HeaderViewModel(
      name: market.symbol ?? "",
      price: market.price_24h ?? 0,
      lastTradePrice: market.last_trade_price ?? 0)
  }
  

  
  // MARK: - Fetch Data For TableViews
  
  // Fetch the ASKS and BIDS for a single crypto currency.
  
  @Published var presentStatsAlert: Bool = false
  @Published var asks: [CryptoPrice] = []
  @Published var bids: [CryptoPrice] = []
  
  
  // Fetch data through the API
  func fetchTableViewData(with symbol: String) {
    
    let queryString = Endpoint.l2.rawValue + symbol
    
    cryptoDataAPI.fetchCryptoMarkets(from: queryString)
      .sink { [unowned self] completion in
        if case let .failure(error) = completion {
          self.handleError(error)
        }
      }
    receiveValue: { [unowned self] in
      /*
       If successful, check that the data returned
       has ASK and/or BID arrays, otherwise,
       tell the view to alert the user.
       */
      let market: CryptoMarket = $0
      self.checkForStats(for: market)
    }
    .store(in: &self.subscriptions)
  }
  
  /*
   Check that the data model contains ASK and/or
   BID arrays.
   */
  func checkForStats(for market: CryptoMarket) {
    let asksArray = market.asks ?? []
    let bidsArray = market.bids ?? []
    
    if asksArray.count > 0 || bidsArray.count > 0
    {
      asks = asksArray
      bids = bidsArray
    }
    else {
      /*
       Tell the view to alert the user that
       this crypto currency doesn't contain data
       */
      presentStatsAlert = true
    }
  }
  
  
  // MARK: - Handle errors
  
  func handleError(_ apiError: CryptoDataAPIError) {
    print("ERROR: \(apiError.localizedDescription)!!!!!")
  }
  
  
  // MARK: - Timer
  
  // Timer to refresh the data every 10 seconds
  
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


