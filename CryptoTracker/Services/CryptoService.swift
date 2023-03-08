/*
 CryptoService.swift
 
 The service to decode any type
 of JSON format.
 
 Created by Cristina Dobson
 */


import Foundation
import Combine

protocol CryptoService {
  func fetchCryptoMarkets<T: Codable>(from endpoint: String) -> Future<T, CryptoDataAPIError>
}

/*
 Endpoints used:
 
 - tickers : in CryptoCollectionViewModel
 - singleTicker : in CryptoDetailViewModel
 - l2 : in CryptoDetailViewModel
 */
enum Endpoint: String {
  case tickers
  case singleTicker = "tickers/"
  case l2 = "l2/"
}
