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
  
  func startViewModel(with prices: [CryptoPrice], andGraph size: CGSize) {
    var newPrices = prices
    newPrices.removeLast()
    graphPoints = createGraphPoints(for: newPrices, for: size)
  }
  
  
  // MARK: - Create Graph Points
  
  var xCoordinate: CGFloat = 0
  
  private func createGraphPoints(for prices: [CryptoPrice], for graphSize: CGSize) -> [CGPoint] {
    
    var pointArray: [CGPoint] = [CGPoint.zero]
    
    let graphHeight = graphSize.height
    let pointSize = getPointSize(for: graphHeight, with: prices)
    let stride = getStride(for: prices.count, withSize: graphSize.width)
    xCoordinate = stride
    
    for price in prices.reversed() {
      
      let yCoordinate = ((price.px ?? 0) * pointSize)/2
      let point = CGPoint(x: xCoordinate, y: -yCoordinate)
      pointArray.append(point)
      xCoordinate += stride
    }
    xCoordinate = 0

    return pointArray
  }
  
  private func getStride(for count: Int, withSize distance: CGFloat) -> CGFloat {
    // Ignore the first point at x=0
    let newCount = count - 1
    return distance / CGFloat(newCount)
  }
  
  private func getPointSize(for height: CGFloat, with prices: [CryptoPrice]) -> CGFloat {
    let maxPrice = prices.max {
      $0.px! < $1.px!
    }?.px
    
    let pointSize = height / CGFloat(maxPrice!)
    return pointSize / 2
  }
  
  
}
