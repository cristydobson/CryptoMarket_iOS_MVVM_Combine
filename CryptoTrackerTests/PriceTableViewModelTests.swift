//
//  PriceTableViewModelTests.swift
//  CryptoTrackerTests
//
//  Created by Cristina Dobson on 3/6/23.
//

import XCTest
@testable import CryptoTracker

final class PriceTableViewModelTests: XCTestCase {

  var sut: PriceTableViewModel!
  var cryptoPriceArray: [CryptoPrice]!
  
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = PriceTableViewModel()
    
    createCryptoPriceArray()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    
    try super.tearDownWithError()
  }
  
  
  // MARK: Setup
  
  func createCryptoPriceArray() {
    cryptoPriceArray = [
      CryptoPrice(px: 478.68346, qty: 1.0763, num: 1),
      CryptoPrice(px: 29.6785, qty: 0.764, num: 1),
      CryptoPrice(px: 87.8, qty: 0.1, num: 1)
    ]
  }
  

  // MARK: - Setup View Model
  
  func testBuildCellModel_whenCryptoPriceModelGiven() {
    // given
    let cryptoPrice = cryptoPriceArray.first!
    let expectedModel = PriceCellViewModel(price: cryptoPrice.px!,
                                           amount: cryptoPrice.qty!,
                                           priceType: .ask)
    
    // when
    sut.priceType = .ask
    let priceCellViewModel = sut.buildCellModel(from: cryptoPrice)
    
    // then
    XCTAssertEqual(priceCellViewModel, expectedModel)
  }
  
  
  
  
}
