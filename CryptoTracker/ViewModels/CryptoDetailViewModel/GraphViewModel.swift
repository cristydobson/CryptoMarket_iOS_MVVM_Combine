//
//  GraphViewModel.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/28/23.
//


import UIKit
import Charts


class GraphViewModel {
  
  
  // MARK: - Properties
  
  var graphPoints: [CGPoint] = []
  
  
  // MARK: - Start View Model
  
  func startViewModel(with prices: [CryptoPrice]) {
    graphPoints = createGraphPoints(for: prices)
  }
  
  
  // MARK: - Create Graph Points
    
  private func createGraphPoints(for prices: [CryptoPrice]) -> [CGPoint] {
  
    var pointArray: [CGPoint] = []
    
    var xCoordinate = prices.count

    for i in 1..<prices.count {

      let price1 = prices[i-1].px ?? 0
      let price2 = prices[i].px ?? 0
      let percentage = price1.getPercentageChange(from: price2)

      if percentage < 1000 {
        let yCoordinate = percentage
        let point = CGPoint(x: Double(xCoordinate), y: yCoordinate)
        pointArray.append(point)
        xCoordinate -= 1
      }
    }
    
    pointArray.append(CGPoint(x: 0, y: 5))
    
    return pointArray.reversed()
  }
  
  func getChartData() -> LineChartData {
    
    var chartEntries: [ChartDataEntry] = []
    
    for point in graphPoints {
      let dataEntry = ChartDataEntry(x: Double(point.x),
                                     y: Double(point.y))
      chartEntries.append(dataEntry)
    }
    
    let line = LineChartDataSet(entries: chartEntries,
                                label: "Asks % Change")
    line.colors = [UIColor.red]
    line.drawCirclesEnabled = false
    
    line.drawValuesEnabled = false
    
    setup(line)
    
    return LineChartData(dataSet: line)
  }
  
  private func setup(_ dataSet: LineChartDataSet) {
    dataSet.setCircleColor(.green)
    dataSet.gradientPositions = [0, 40, 100]
    dataSet.lineWidth = 3
    dataSet.valueFont = .systemFont(ofSize: 12)
  }

  
}
