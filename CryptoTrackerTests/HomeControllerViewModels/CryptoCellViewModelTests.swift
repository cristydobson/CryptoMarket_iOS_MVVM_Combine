//
//  CryptoCellViewModelTests.swift
//  CryptoTrackerTests
//
//  Created by Cristina Dobson on 3/6/23.
//

import XCTest
@testable import CryptoTracker


final class CryptoCellViewModelTests: XCTestCase {

  var sut: CryptoCellViewModel!
  
  
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Setup
  
  func createCellViewModel(name: String?, price: Double?, lastTradePrice: Double?) {
    sut = CryptoCellViewModel(symbol: name, price24h: price, volume24h: 1, lastTradePrice: lastTradePrice)
  }
  
  
  // MARK: - Get Price Percentage Change String
  
  func testGetPricePercentageChangeString_whenPropertiesNonNil() {
    // given
    createCellViewModel(name: "BTC-USD", price: 584.5846, lastTradePrice: 587.674)
    let expectedString = StringHelper.getPercentageChange(for: sut.price24h!, from: sut.lastTradePrice!)
    
    // when
    let percentageString = sut.getPricePercentageChangeString()
    
    // then
    XCTAssertEqual(percentageString, expectedString)
  }
  
  func testGetPricePercentageChangeString_whenPricePropertyNil() {
    // given
    createCellViewModel(name: "BTC-USD", price: nil, lastTradePrice: 587.674)
    let expectedString = StringHelper.getPercentageChange(for: 0, from: sut.lastTradePrice!)

    // when
    let percentageString = sut.getPricePercentageChangeString()

    // then
    XCTAssertEqual(percentageString, expectedString)
  }

  func testGetPricePercentageChangeString_whenLastTradePricePropertyNil() {
    // given
    createCellViewModel(name: "BTC-USD", price: 587.674, lastTradePrice: nil)
    let expectedString = StringHelper.getPercentageChange(for: sut.price24h!, from: 0)

    // when
    let percentageString = sut.getPricePercentageChangeString()

    // then
    XCTAssertEqual(percentageString, expectedString)
  }

  func testGetPricePercentageChangeString_whenAllPropertiesNil() {
    // given
    createCellViewModel(name: "BTC-USD", price: nil, lastTradePrice: nil)
    let expectedString = StringHelper.getPercentageChange(for: 0, from: 0)

    // when
    let percentageString = sut.getPricePercentageChangeString()

    // then
    XCTAssertEqual(percentageString, expectedString)
  }
  
  
  // MARK: - Get Crypto Name String

  func testGetCryptoNameString_whenSymbolNotNil() {
    // given
    createCellViewModel(name: "BTC-USD", price: nil, lastTradePrice: nil)
    let expectedString = "BTC"
    
    // when
    let nameString = sut.getCryptoNameString()
    
    // then
    XCTAssertEqual(nameString, expectedString)
  }

  func testGetCryptoNameString_whenSymbolNil() {
    // given
    createCellViewModel(name: "", price: nil, lastTradePrice: nil)
    let expectedString = ""
    
    // when
    let nameString = sut.getCryptoNameString()
    
    // then
    XCTAssertEqual(nameString, expectedString)
  }
  
  
  // MARK: - Get Price String
  
  func testGetPriceString_whenLastTradePricePropertyNonNil() {
    // given
    createCellViewModel(name: "BTC-USD", price: 577.674, lastTradePrice: 587.674)
    let expectedString = "$587.67"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenLastTradePricePropertyNil() {
    // given
    createCellViewModel(name: "BTC-USD", price: 577.674, lastTradePrice: nil)
    let expectedString = "$0.00"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenSymbolPropertyNil() {
    // given
    createCellViewModel(name: nil, price: 577.674, lastTradePrice: 587.674)
    let expectedString = "0.00"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
}


