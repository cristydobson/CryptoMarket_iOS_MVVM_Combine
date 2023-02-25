//
//  CryptoDataAPIError.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import Foundation

enum CryptoDataAPIError: Error, LocalizedError {
  case urlError(URLError)
  case responseError(Int)
  case decodingError(DecodingError)
  case anyError
  
  var localizedDescription: String {
    switch self {
      case .urlError(let error):
        return error.localizedDescription
      case .decodingError(let error):
        return error.localizedDescription
      case .responseError(let error):
        return "Bad response code: \(error)"
      case .anyError:
        return "Unknown error has ocurred"
    }
  }
}
