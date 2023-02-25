//
//  CryptoService.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import Foundation
import Combine

protocol CryptoService {
  func fetchCryptoMarkets() -> Future<[CryptoMarket], CryptoDataAPIError>
}
