/*
 CryptoCollectionViewTests.swift
 
 Created by Cristina Dobson
 */


import XCTest
@testable import CryptoTracker


final class CryptoCollectionViewModelTests: XCTestCase {

  var sut: CryptoCollectionViewModel!
  var cryptoMarkets: [CryptoMarket]!
  let cryptoSymbol = "BTC-USD"
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = CryptoCollectionViewModel()
    createCryptoMarketArray()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    cryptoMarkets = nil
    
    try super.tearDownWithError()
  }
  
  func createCryptoMarketArray() {
    cryptoMarkets = [
      CryptoMarket(
        symbol: cryptoSymbol, price_24h: 43.834697,
        volume_24h: 0.035, last_trade_price: 40.67856,
        bids: nil, asks: nil),
      CryptoMarket(
        symbol: nil, price_24h: 597.89763,
        volume_24h: 0.035, last_trade_price: 567.8869,
        bids: nil, asks: nil),
      CryptoMarket(
        symbol: cryptoSymbol, price_24h: nil,
        volume_24h: 0.035, last_trade_price: 567.8869,
        bids: nil, asks: nil),
      CryptoMarket(
        symbol: cryptoSymbol, price_24h: 597.89763,
        volume_24h: 0.035, last_trade_price: nil,
        bids: nil, asks: nil),
      CryptoMarket(
        symbol: cryptoSymbol, price_24h: nil,
        volume_24h: 0.035, last_trade_price: nil,
        bids: nil, asks: nil),
      CryptoMarket(
        symbol: nil, price_24h: nil,
        volume_24h: 0.035, last_trade_price: nil,
        bids: nil, asks: nil),
    ]
  }
  
  
  // MARK: - Helper Methods
  
  func createCellModel(from market: CryptoMarket) -> CryptoCellViewModel {
    return CryptoCellViewModel(
      symbol: market.symbol, price24h: market.price_24h,
      volume24h: market.volume_24h, lastTradePrice: market.last_trade_price)
  }
  
  func createCellViewModelArray() -> [CryptoCellViewModel] {
    var viewModels: [CryptoCellViewModel] = []
    
    for market in cryptoMarkets {
      let viewModel = CryptoCellViewModel(
        symbol: market.symbol, price24h: market.price_24h,
        volume24h: market.volume_24h, lastTradePrice: market.last_trade_price)
      viewModels.append(viewModel)
    }
  
    viewModels.sort {
      $0.symbol ?? "" < $1.symbol ?? ""
    }
    
    return viewModels
  }
  
  
  // MARK: - Build Single Cell View Model
  
  func testBuildCellModel_whenCryptoMarketModelGiven() {
    // given
    let market = cryptoMarkets[0]
    let expectedViewModel = createCellModel(from: market)
    
    // when
    let viewModel = sut.buildCellModel(from: market)
    
    // then
    XCTAssertEqual(viewModel, expectedViewModel)
  }
  
  
  // MARK: - Create Cell View Model Array
  
  func testCreateCellViewModels_whenCryptoMarketArrayGiven() {
    // given
    let expectedViewModelArray = createCellViewModelArray()
    
    // when
    let viewModels = sut.createCellViewModels(from: cryptoMarkets)
    
    // then
    XCTAssertEqual(viewModels, expectedViewModelArray)
  }
  
  
  // MARK: - Get Cell View Model
  
  func testGetCellViewModel_givenIndexPath() {
    // given
    let indexPath = IndexPath(row: 1, section: 1)
    let expectedViewModel = createCellViewModelArray()[indexPath.row]

    // when
    let viewModels = sut.createCellViewModels(from: cryptoMarkets)
    sut.cryptoCellViewModels = viewModels
    let viewModel = sut.getCellViewModel(at: indexPath)

    // then
    XCTAssertEqual(viewModel, expectedViewModel)
  }
  

}



