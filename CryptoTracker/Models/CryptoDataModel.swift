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


//struct Structure: Codable {
//  
//  let market: CryptoMarket
//  let markets: [CryptoMarket]
//  
//  init(market: CryptoMarket, markets: [CryptoMarket]) {
//    self.market = market
//    self.markets = markets
//  }
//  
//  enum CodingKeys: String, CodingKey { case market, markets }
//  
//  public func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encodeIfPresent(market, forKey: .market)
//    try container.encodeIfPresent(markets, forKey: .markets)
//  }
//  
//}
