//
//  CryptoService.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import Foundation
import Combine

protocol CryptoService {
  func fetchCryptoMarkets<T: Codable>(from endpoint: String) -> Future<T, CryptoDataAPIError>
}
//Future<[CryptoMarket], CryptoDataAPIError>

enum Endpoint: String {
  case tickers
  case l2 = "l2/"
}
