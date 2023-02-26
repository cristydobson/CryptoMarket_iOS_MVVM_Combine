//
//  CryptoDataModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//


// MARK: - Crypto Markets

struct CryptoMarket: Codable {
  let symbol: String?
  let price_24h: Double?
  let volume_24h: Double?
  let last_trade_price: Double?
  let bids: [CryptoPrice]?
  let asks: [CryptoPrice]?
}


struct CryptoPrice: Codable {
  let px: Double?
  let qty: Double?
  let num: Int?
}

