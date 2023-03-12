/*
 ApiTests.swift
 
 Test that the API endpoints get an
 HTTP Status Code 200.
 
 Created by Cristina Dobson
 */


import XCTest
import Network
import Combine
@testable import CryptoTracker


final class ApiTests: XCTestCase {

  var sut: CryptoDataLoader!
  private let monitor = NWPathMonitor()
  private var status = NWPath.Status.requiresConnection
  
  private var subscriptions = Set<AnyCancellable>()
  private let baseApiURL = "https://api.blockchain.com/v3/exchange/"
  var endpointAllTickers: String!
  var endpointSingleTicker: String!
  var endpointBidsAsks: String!
  
  
  // MARK: - Setup Methods
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    startNetworkMonitoring()
    sut = CryptoDataLoader.shared
    createEndpoints()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    stopNetworkMonitoring()
    
    try super.tearDownWithError()
  }
  
  func createEndpoints() {
    let cryptoSymbol = "BTC-USD"
    endpointAllTickers = Endpoint.tickers.rawValue
    endpointSingleTicker = Endpoint.singleTicker.rawValue + cryptoSymbol
    endpointBidsAsks = Endpoint.l2.rawValue + cryptoSymbol
  }
  
  
  // MARK: - Support Methods
  
  func startNetworkMonitoring() {
    monitor.pathUpdateHandler = { [weak self] path in
      self?.status = path.status
    }
    let queue = DispatchQueue(label: "NetworkMonitor")
    monitor.start(queue: queue)
  }
  
  func stopNetworkMonitoring() {
    monitor.cancel()
  }
  
  
  // MARK: - Successfully fetch data from all enpoints
    
  // let endpoint = Endpoint.tickers
  func testGivenTickersEndpoint_whenMakingApiCall_thenReceiveData() throws {

    try XCTSkipUnless(status == .satisfied, "No network available for testing!!")

    // given
    let promise = expectation(description: "Data was received!!")
    
    // when
    sut.fetchCryptoMarkets(from: endpointAllTickers)
      // then
      .sink { completion in
        if case let .failure(error) = completion {
          XCTFail("Error: \(error.localizedDescription)")
        }
      } receiveValue: {
        let _: [CryptoMarket] = $0
        promise.fulfill()
      }
      .store(in: &self.subscriptions)

      wait(for: [promise], timeout: 5)
    
  }
  
  // let endpoint = Endpoint.singleTicker
  func testGivenSingleTickerEndpoint_whenMakingApiCall_thenReceiveData() throws {
    
    try XCTSkipUnless(status == .satisfied, "No network available for testing!!")
    
    // given
    let promise = expectation(description: "Data was received!!")
    
    // when
    sut.fetchCryptoMarkets(from: endpointSingleTicker)
    // then
      .sink { completion in
        if case let .failure(error) = completion {
          XCTFail("Error: \(error.localizedDescription)")
        }
      } receiveValue: {
        let _: CryptoMarket = $0
        promise.fulfill()
      }
      .store(in: &self.subscriptions)
    
    wait(for: [promise], timeout: 5)
    
  }
  
  // let endpoint = Endpoint.l2 + "\(ticker)"
  func testGivenL2PlusTickerEndpoint_whenMakingApiCall_thenReceiveData() throws {
    
    try XCTSkipUnless(status == .satisfied, "No network available for testing!!")
    
    // given
    let promise = expectation(description: "Data was received!!")
    
    // when
    sut.fetchCryptoMarkets(from: endpointBidsAsks)
    // then
      .sink { completion in
        if case let .failure(error) = completion {
          XCTFail("Error: \(error.localizedDescription)")
        }
      } receiveValue: {
        let _: CryptoMarket = $0
        promise.fulfill()
      }
      .store(in: &self.subscriptions)
    
    wait(for: [promise], timeout: 5)
    
  }
    

}
