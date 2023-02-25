//
//  CryptoDataModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

struct CryptoDataModel: Codable {
  let results: [CryptoMarket]
}

struct CryptoMarket: Codable {
  let symbol: String
  let price_24h: Double
  let volume_24h: Double
  let last_trade_price: Double
}
