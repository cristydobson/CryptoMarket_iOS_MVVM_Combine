//
//  ImageHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 3/1/23.
//

import UIKit


struct ImageHelper {
  
  static func getCryptoIcon(for coin: String?) -> UIImage? {
    
    if let coinName = coin,
       let url = Bundle.main.url(forResource: coinName.lowercased(), withExtension: "png") {
      
      let imgData = try! Data(contentsOf: url)
      return UIImage(data: imgData)
    }
    return UIImage(named: "crypto-placeholder")
  }
  
}
