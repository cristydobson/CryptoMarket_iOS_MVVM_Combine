/*
 GraphViewModel.swift
 
 The ViewModel for GraphView.
 
 Setup the chart to display given data points.
 
 Created by Cristina Dobson
 */


import UIKit
import Charts


class GraphViewModel {
  
  
  // MARK: - Properties
  
  var graphPoints: [CGPoint] = []

  
  // MARK: - Setup the Chart
  
  func startViewModel(with prices: [CryptoPrice]) {
    graphPoints = createGraphPoints(for: prices)
  }
    
  // Calculate the data points to display on the chart.
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
    
    // Starting point
    pointArray.append(CGPoint(x: 0, y: 5))
    
    return pointArray.reversed()
  }
  
  
  // MARK: - Setup the Line Chart
  
  // Tell the chart how to draw the lines
  func getChartData() -> LineChartData {
    
    var chartEntries: [ChartDataEntry] = []
    
    for point in graphPoints {
      let dataEntry = ChartDataEntry(x: Double(point.x),
                                     y: Double(point.y))
      chartEntries.append(dataEntry)
    }
    
    let line = LineChartDataSet(
      entries: chartEntries, label: "Asks % Change")
    line.colors = [UIColor.red]
    line.drawCirclesEnabled = false
    
    line.drawValuesEnabled = false
    line.lineWidth = 3
    
    return LineChartData(dataSet: line)
  }
  
}
