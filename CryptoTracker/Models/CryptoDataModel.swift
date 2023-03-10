/*
 CryptoDataModel.swift
 
 Models for decoding the JSON data returned
 by the Blockchain API.
 
 Created by Cristina Dobson
 */


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




