//
//  GraphViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/28/23.
//

import UIKit

class GraphViewModel {
  
  
  // MARK: - Properties
  
  var graphPoints: [CGPoint] = []
  
  
  // MARK: - Start View Model
  
  func startViewModel(with prices: [CryptoPrice]) {
    graphPoints = createGraphPoints(for: prices)
  }
  
  
  // MARK: - Create Graph Points
  
  var xCoordinate: CGFloat = 0
  
  func createGraphPoints(for prices: [CryptoPrice]) -> [CGPoint] {
    
    var pointArray: [CGPoint] = []
    
    for price in prices {
      let yCoordinate: CGFloat = price.px ?? 0
      let point = CGPoint(x: xCoordinate, y: yCoordinate)
      pointArray.append(point)
      xCoordinate += 20
    }
    print("POINTS: \(graphPoints.debugDescription)!!!!!!!")
    return pointArray
  }
  
  
  
  
  
}
