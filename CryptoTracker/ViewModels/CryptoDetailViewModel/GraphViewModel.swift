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
    
    let graphHeight = graphSize.height
    var pointArray: [CGPoint] = [CGPoint(x: xCoordinate, y: graphHeight/2)]
    
    
//    let pointSize = getPointSize(for: graphHeight, with: prices)
    let stride = getStride(for: prices.count, withSize: graphSize.width)
    xCoordinate = stride
    
    for i in (0..<prices.count-1).reversed() {
      
      let price1 = prices[i].px ?? 0
      let price2 = prices[i+1].px ?? 0
      let percentage = price2.getPercentageChange(from: price1)
      let yCoordinate = (percentage * 4)
      print("price1: \(price1), price2: \(price2), Y: \(yCoordinate)!!!!!!!")
      let point = CGPoint(x: xCoordinate, y: yCoordinate)
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
  
//  private func getPointSize(for height: CGFloat, with prices: [CryptoPrice]) -> CGFloat {
//    let maxPrice = prices.max {
//      $0.px! < $1.px!
//    }?.px
//    
//    let pointSize = height / CGFloat(maxPrice!)
//    return pointSize / 2
//  }
  
  
}
