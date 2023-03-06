//
//  HeaderViewModelTests.swift
//  CryptoTrackerTests
//
//  Created by Cristina Dobson on 3/6/23.
//

import XCTest
@testable import CryptoTracker


final class HeaderViewModelTests: XCTestCase {

  var sut: HeaderViewModel!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: - Helper Methods
  func createHeaderModelWith(name: String?, price: Double?, lastTradePrice: Double?) {
    sut = HeaderViewModel(name: name, price: price, lastTradePrice: lastTradePrice)
  }
  
  
  // MARK: - Get Price String
  
  func testGetPriceString_whenNonNilLastTradePriceProperty() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: 437.674, lastTradePrice: 78.96743)
    let expectedString = "$78.97"
    
    // when
    let priceString = sut.getPriceString()
    
    // then
    XCTAssertEqual(priceString, expectedString)
  }
  
  func testGetPriceString_whenNilLastTradePriceProperty() {
    // given
    createHeaderModelWith(name: "BTC-USD", price: 437.674, lastTradePrice: nil)
  }
  
  
  
}
