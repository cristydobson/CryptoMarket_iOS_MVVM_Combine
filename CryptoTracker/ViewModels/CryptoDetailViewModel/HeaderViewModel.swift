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
    return ImageHelper.getCryptoIcon(for: name)!
  }
  
  func getPriceString() -> String {
    return "⚑  " + StringHelper.getString(for: price!,
                                          withCharacter: 8)
  }
  

  
}
