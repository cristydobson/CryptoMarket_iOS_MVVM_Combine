//
//  HeaderViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 3/1/23.
//

import Foundation
import UIKit


struct HeaderViewModel {
  
  
  // MARK: - Properties
  
  let name: String?
  let price: Double?
  
  
  // MARK: - Methods
  
  func getImage() -> UIImage {
    let coinName = name?.getCryptoNameString()
    return ImageHelper.getCryptoIcon(for: coinName)!
  }
  
  func getPriceString() -> String {
    return "⚑  " + StringHelper.getString(for: price!,
                                          withCharacter: 8)
  }
  

  
}
