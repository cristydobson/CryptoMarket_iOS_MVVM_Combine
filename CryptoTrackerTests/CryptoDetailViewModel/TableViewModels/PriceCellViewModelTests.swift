/*
 PriceCellViewModelTests.swift
 
 Created by Cristina Dobson
 */


import XCTest
@testable import CryptoTracker

final class PriceCellViewModelTests: XCTestCase {
  
  var sut: PriceCellViewModel!
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Init SUT
  
  func createSutWith(price: Double, amount: Double, priceType: PriceType) {
    sut = PriceCellViewModel(
      price: price, amount: amount, priceType: priceType)
  }
  
  
  // MARK: - Price String
  
  func testGetPriceString_whenDigitCountGreaterThanZero() {
    // given
    createSutWith(price: 420.026983, amount: 1.083754, priceType: .ask)
    let expectedString = "420.0269"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenDigitCountBetweenZeroAndEight() {
    // given
    createSutWith(price: 420.0, amount: 1.083754, priceType: .ask)
    let expectedString = "420.0000"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenNoDecimals() {
    // given
    createSutWith(price: 4, amount: 1.083754, priceType: .ask)
    let expectedString = "4.000000"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenValueIsZero() {
    // given
    createSutWith(price: 0, amount: 1.083754, priceType: .ask)
    let expectedString = "0.000000"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  
  // MARK: Amount String
  
  func testGetAmountString_whenValueIsZero() {
    // given
    createSutWith(price: 420.026, amount: 0, priceType: .ask)
    let expectedString = "0.00000"
    
    // when
    let priceString = sut.getAmountString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetAmountString_whenDigitCountGreaterZero() {
    // given
    createSutWith(price: 420.026, amount: 1.083754, priceType: .ask)
    let expectedString = "1.08375"
    
    // when
    let priceString = sut.getAmountString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  
  // MARK: - Price Label Color
  
  func testGetPriceLabelColor_whenPriceModelIsTypeAsk() {
    // given
    createSutWith(price: 420.026, amount: 1.083754, priceType: .ask)
    
    // when
    let labelColor = sut.getPriceLabelColor()
    
    // then
    XCTAssertEqual(labelColor, UIColor.red)
  }
  
  func testGetPriceLabelColor_whenPriceModelIsTypeBid() {
    // given
    createSutWith(price: 420.026, amount: 1.083754, priceType: .bid)
    
    // when
    let labelColor = sut.getPriceLabelColor()
    
    // then
    XCTAssertEqual(labelColor, UIColor.green)
  }
  
}

