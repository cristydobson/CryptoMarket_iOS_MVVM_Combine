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
    cryptoPriceArray = []
    
    try super.tearDownWithError()
  }
  
  
  // MARK: Setup
  
  func createCryptoPriceArray() {
    cryptoPriceArray = [
      CryptoPrice(px: 478.68346, qty: 1.0763, num: 1),
      CryptoPrice(px: 478.68346, qty: nil, num: 1),
      CryptoPrice(px: 29.6785, qty: 0.764, num: 1),
      CryptoPrice(px: 87.8, qty: 0.1, num: 1),
      CryptoPrice(px: nil, qty: 0.1, num: 1)
    ]
  }
  
  
  // MARK: Helper Methods
  
  func createCellViewModel(for cryptoPrice: CryptoPrice) -> PriceCellViewModel {
    
    return PriceCellViewModel(price: cryptoPrice.px, amount: cryptoPrice.qty, priceType: .ask)
  }
  
  func createCellViewModelArray() -> [PriceCellViewModel] {
    
    var viewModels: [PriceCellViewModel] = []
    
    for price in cryptoPriceArray {
      let cellViewModel = PriceCellViewModel(price: price.px, amount: price.qty, priceType: .ask)
      viewModels.append(cellViewModel)
    }
    return viewModels
  }
  

  // MARK: - Build Single Cell View Model
  
  func testBuildCellModel_whenCryptoPriceModelGiven() {
    // given
    let cryptoPrice = cryptoPriceArray[0]
    let expectedModel = createCellViewModel(for: cryptoPrice)
    
    // when
    let priceCellViewModel = sut.buildCellModel(from: cryptoPrice)
    
    // then
    XCTAssertEqual(priceCellViewModel, expectedModel)
  }
  
  
  // MARK: - Create Cell View Model Array
  
  func testCreateCellViewModels_whenCryptoPriceArrayGiven() {
    // given
    let expectedViewModelArray = createCellViewModelArray()
    
    // when
    let viewModels = sut.createCellViewModels(from: cryptoPriceArray)
    
    // then
    XCTAssertEqual(viewModels, expectedViewModelArray)
  }
  
  func testSetupViewModel_whenCryptoPriceArrayGiven() {
    // given
    let expectedViewModelArray = createCellViewModelArray()
    
    // when
    sut.setupViewModel(with: cryptoPriceArray, for: .ask)
    let cellViewModels = sut.priceCellViewModels
    
    // then
    XCTAssertEqual(cellViewModels, expectedViewModelArray)
  }
  
  
  // MARK: - Get Cell View Model
  
  func testGetCellViewModel_givenIndexPath() {
    // given
    let indexPath = IndexPath(row: 1, section: 1)
    let cryptoPrice = cryptoPriceArray[indexPath.row]
    let expectedViewModel = createCellViewModel(for: cryptoPrice)
    
    // when
    sut.setupViewModel(with: cryptoPriceArray, for: .ask)
    let viewModel = sut.getCellViewModel(at: indexPath)
    
    // then
    XCTAssertEqual(viewModel, expectedViewModel)
  }
  
  
}
