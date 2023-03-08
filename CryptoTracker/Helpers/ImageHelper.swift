/*
 ImageHelper.swift
 
 Created by Cristina Dobson
 */


import UIKit


// MARK: - Image Helper 

struct ImageHelper {
  
  // Get an image from the Bundle
  static func getCryptoIcon(for coin: String?) -> UIImage? {
    
    if let coinName = coin,
       let url = Bundle.main.url(forResource: coinName.lowercased(), withExtension: "png") {
      
      let imgData = try! Data(contentsOf: url)
      return UIImage(data: imgData)
    }
    return UIImage(named: "crypto-placeholder")
  }
  
}
