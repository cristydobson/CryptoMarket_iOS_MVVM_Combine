/*
 CryptoDetailViewModelTests.swift
 
 Created by Cristina Dobson
 */


import XCTest
@testable import CryptoTracker

final class CryptoDetailViewModelTests: XCTestCase {

  var sut: CryptoDetailViewModel!
  var cryptoTicker: CryptoMarket!
  let cryptoSymbol = "BTC-USD"
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = CryptoDetailViewModel()
    createCryptoTicker()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    cryptoTicker = nil
    
    try super.tearDownWithError()
  }
  
  func createCryptoTicker() {
    cryptoTicker = CryptoMarket(
      symbol: cryptoSymbol, price_24h: 4998, volume_24h: 0.3015,
      last_trade_price: 5000, bids: nil, asks: nil)
  }
  
  
  // MARK: - Helper Methods
  
  func createHeaderViewModel() -> HeaderViewModel {
    return HeaderViewModel(
      name: cryptoTicker.symbol ?? "",
      price: cryptoTicker.price_24h ?? 0,
      lastTradePrice: cryptoTicker.last_trade_price ?? 0)
  }
  
  func createCryptoMarket(with asks: [CryptoPrice]?, and bids: [CryptoPrice]?) -> CryptoMarket {
    return CryptoMarket(
      symbol: cryptoSymbol, price_24h: nil,
      volume_24h: nil, last_trade_price: nil,
      bids: bids, asks: asks)
  }
  
  func createCryptoPriceArray() -> [CryptoPrice] {
    return [
      CryptoPrice(px: 674.786, qty: 2.9873, num: 1),
      CryptoPrice(px: 86.49326, qty: 1.08763, num: 1)
    ]
  }
  
  
  // MARK: - Fetch Data for Header
  
  func testCreateHeaderViewModel_whenCryptoTickerLoaded() {
    // given
    let expectedViewModel = createHeaderViewModel()
    
    // when
    let viewModel = sut.createHeaderViewModel(from: cryptoTicker)
    
    // then
    XCTAssertEqual(viewModel, expectedViewModel)
  }
  
  
  // MARK: - Fetch TableViews Data
  
  func testCheckForStats_whenAsksBidsArraysNil_thenCryptoMarketIsNil() {
    // given
    let market = createCryptoMarket(with: nil, and: nil)
    
    // when
    sut.checkForStats(for: market)
    let asks = sut.asks
    let bids = sut.bids
    
    // then
    XCTAssertTrue(asks.count == 0)
    XCTAssertTrue(bids.count == 0)
  }
  
  func testCheckForStats_whenAsksBidsArraysNonNil_thenCryptoMarketIsNotNil() {
    // given
    let cryptoPriceArray = createCryptoPriceArray()
    let market = createCryptoMarket(with: cryptoPriceArray, and: cryptoPriceArray)
    
    // when
    sut.checkForStats(for: market)
    let asks = sut.asks
    let bids = sut.bids
    
    // then
    XCTAssertTrue(asks.count == 2)
    XCTAssertTrue(bids.count == 2)
  }
  
  func testCheckForStats_whenAsksArrayNil_thenCryptoMarketIsNotNil() {
    // given
    let cryptoPriceArray = createCryptoPriceArray()
    let market = createCryptoMarket(with: nil, and: cryptoPriceArray)
    
    // when
    sut.checkForStats(for: market)
    let asks = sut.asks
    let bids = sut.bids
    
    // then
    XCTAssertTrue(asks.count == 0)
    XCTAssertTrue(bids.count == 2)
  }
  
}
