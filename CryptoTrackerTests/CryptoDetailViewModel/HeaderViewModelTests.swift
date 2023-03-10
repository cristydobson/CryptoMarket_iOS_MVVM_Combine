/*
 HeaderViewModelTests.swift
 
 Created by Cristina Dobson
 */


import XCTest
@testable import CryptoTracker


final class HeaderViewModelTests: XCTestCase {

  var sut: HeaderViewModel!
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Init SUT
  
  func createHeaderModelWith(name: String?, price: Double?, lastTradePrice: Double?) {
    sut = HeaderViewModel(name: name, price: price, lastTradePrice: lastTradePrice)
  }
  
  
  // MARK: - Get Price String
  
  func testGetPriceString_whenLastTradePricePropertyNonNil() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: 437.674, lastTradePrice: 78.96743)
    let expectedString = "$78.97"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenLastTradePricePropertyNil() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: 437.674, lastTradePrice: nil)
    let expectedString = "$0.00"

    // when
    let priceString = sut.getPriceString()

    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenNamePropertyNil() {
    // given
    createHeaderModelWith(name: nil, price: 437.674, lastTradePrice: 587.674)
    let expectedString = "0.00"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenNamePropertyContainsNoCurrencyString() {
    // given
    createHeaderModelWith(name: "BTC", price: 437.674, lastTradePrice: 587.674)
    let expectedString = "587.674"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  
  // MARK: - Get Price Percentage Change String
  
  func testGetPricePercentageChangeString_whenPropertiesNonNil() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: 437.674, lastTradePrice: 447.674)
    let expectedString = StringHelper.getPercentageChange(for: sut.price!, from: sut.lastTradePrice!)
    
    // when
    let percentageString = sut.getPricePercentageChangeString()
    
    // then
    XCTAssertEqual(percentageString, expectedString)
  }
  
  func testGetPricePercentageChangeString_whenPricePropertyNil() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: nil, lastTradePrice: 447.674)
    let expectedString = "+0.00%"
    
    // when
    let percentageString = sut.getPricePercentageChangeString()
    
    // then
    XCTAssertEqual(percentageString, expectedString)
  }
  
  func testGetPricePercentageChangeString_whenLastTradePricePropertyNil() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: 437.674, lastTradePrice: nil)
    let expectedString = StringHelper.getPercentageChange(for: sut.price!, from: 0)
    
    // when
    let percentageString = sut.getPricePercentageChangeString()
    
    // then
    XCTAssertEqual(percentageString, expectedString)
  }
  
  func testGetPricePercentageChangeString_whenAllPropertiesNil() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: nil, lastTradePrice: nil)
    let expectedString = StringHelper.getPercentageChange(for: 0, from: 0)
    
    // when
    let percentageString = sut.getPricePercentageChangeString()
    
    // then
    XCTAssertEqual(percentageString, expectedString)
  }
  
  
  // MARK: - Get Crypto Currency Icon Image
  
  func testGetImage_whenNameNonNil() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: 437.674, lastTradePrice: 447.674)
    
    // when
    let icon = sut.getImage()
    
    // then
    XCTAssertNotNil(icon)
  }
  
  func testGetImage_whenNameNil() {
    // given
    createHeaderModelWith(name: nil, price: 437.674, lastTradePrice: 447.674)
    
    // when
    let icon = sut.getImage()
    
    // then
    XCTAssertNotNil(icon)
  }
  
  func testGetImage_whenNameEmptyString() {
    // given
    createHeaderModelWith(name: "", price: 437.674, lastTradePrice: 447.674)
    
    // when
    let icon = sut.getImage()
    
    // then
    XCTAssertNotNil(icon)
  }
  
}
