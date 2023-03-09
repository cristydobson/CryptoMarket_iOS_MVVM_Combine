/*
 CryptoCollectionViewModel.swift
 
 The ViewModel for CryptoCollectionView.
 
 Fetch the data of crypto currencies
 to display on the HomeScreen.
 
 Created by Cristina Dobson
 */


import Foundation
import Combine


/*
 Tell CryptoCollectionView to reload the collection view
 when the timer is up.
 */
protocol CryptoCollectionViewModelDelegate: AnyObject {
  func reloadCollectionData()
}


class CryptoCollectionViewModel: ObservableObject {
  
  
  // MARK: - Properties
  
  weak var delegate: CryptoCollectionViewModelDelegate?
  
  private var subscriptions = Set<AnyCancellable>()
  var cryptoDataAPI = CryptoDataLoader.shared
  
  @Published var cryptoCellViewModels: [CryptoCellViewModel] = []
  
  
  // MARK: - Fetch Data
  
  // Fetch data through the API
  func fetchData() {

    cryptoDataAPI.fetchCryptoMarkets(from: Endpoint.tickers.rawValue)
      .sink { [unowned self] completion in
        if case let .failure(error) = completion {
          self.handleError(error)
        }
      }
      receiveValue: { [unowned self] in
        let cryptoMarkets: [CryptoMarket] = $0
        self.cryptoCellViewModels = self.createCellViewModels(from: cryptoMarkets)
      }
      .store(in: &self.subscriptions)
  }
  
  // Create CellViewModels from the data response
  func createCellViewModels(from resultsArray: [CryptoMarket]) -> [CryptoCellViewModel] {
    
    var viewModels: [CryptoCellViewModel] = []
    
    for result in resultsArray {
      let cellViewModel = buildCellModel(from: result)
      viewModels.append(cellViewModel)
    }
    
    viewModels.sort {
      $0.symbol ?? "" < $1.symbol ?? ""
    }
    
    return viewModels
  }
  
  // Build a single CellViewModel
  func buildCellModel(from market: CryptoMarket) -> CryptoCellViewModel {
    return CryptoCellViewModel(symbol: market.symbol,
                               price24h: market.price_24h,
                               volume24h: market.volume_24h,
                               lastTradePrice: market.last_trade_price)
  }
  
  // Return a CellViewModel for the current IndexPath
  func getCellViewModel(at indexPath: IndexPath) -> CryptoCellViewModel {
    return cryptoCellViewModels[indexPath.row]
  }
  
  
  // MARK: - Handle errors
  
  func handleError(_ apiError: CryptoDataAPIError) {
    print("ERROR: \(apiError.localizedDescription)!!!!!")
  }
  
  
  // MARK: - Timer
  
  // Timer to refresh the data every 10 seconds
  
  private var timer: AnyCancellable?
  
  func startTimer() {
    timer = Timer
      .publish(every: 10, on: .main, in: .common)
      .autoconnect()
      .sink { _ in
        self.delegate?.reloadCollectionData()
      }
  }
  
  func cancelTimer() {
    timer?.cancel()
  }
  
  
}
