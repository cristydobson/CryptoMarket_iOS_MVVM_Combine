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
  
  func startViewModel(with prices: [CryptoPrice], andGraph size: CGSize) {
    var newPrices = prices
    newPrices.removeLast()
    graphPoints = createGraphPoints(for: newPrices, for: size)
  }
  
  
  // MARK: - Create Graph Points
  
  private func createGraphPoints(for prices: [CryptoPrice], for graphSize: CGSize) -> [CGPoint] {
    
    let graphHeight = graphSize.height
    var pointArray: [CGPoint] = []
    
//    let stride = getStride(for: prices.count, withSize: graphSize.width)
    var xCoordinate = prices.count
    
    for i in 1..<prices.count-1 {

      let price1 = prices[i-1].px ?? 0
      let price2 = prices[i].px ?? 0
      let percentage = price1.getPercentageChange(from: price2)
      let yCoordinate = percentage
      print("price1: \(price1), price2: \(price2), Y: \(yCoordinate)!!!!!!!")
      let point = CGPoint(x: Double(xCoordinate), y: yCoordinate)
      pointArray.append(point)
      xCoordinate -= 1
    }
    pointArray.append(CGPoint(x: 0, y: 5))
    
   
    return pointArray.reversed()
  }
  
//  private func getStride(for count: Int, withSize distance: CGFloat) -> CGFloat {
//    // Ignore the first point at x=0
//    let newCount = count - 1
//    return distance / CGFloat(newCount)
//  }
  
  func getChartData() -> LineChartData {
    
    var chartEntries: [ChartDataEntry] = []
    
    for point in graphPoints {
      let dataEntry = ChartDataEntry(x: Double(point.x),
                                     y: Double(point.y))
      chartEntries.append(dataEntry)
    }
    
    let line = LineChartDataSet(entries: chartEntries,
                                label: "Asks % Change")
    line.colors = [UIColor.red] // [UIColor(red: 121/255, green: 226/255, blue: 251/255, alpha: 1)]
    line.drawCirclesEnabled = false
    
    line.drawValuesEnabled = false
  
//    line.drawIconsEnabled = false
    
    setup(line)
//
//    let gradientColors = [
//      ChartColorTemplates.colorFromString("#00FF0000").cgColor,
//      ChartColorTemplates.colorFromString("FFFF0000").cgColor
//    ]
//    let gradient = CGGradient(colorsSpace: nil,
//                              colors: gradientColors as CFArray,
//                              locations: nil)!
//    line.fillAlpha = 1
//    line.fill = LinearGradientFill(gradient: gradient, angle: 90)
//    line.drawFilledEnabled = true
    
    return LineChartData(dataSet: line)
  }
  
  private func setup(_ dataSet: LineChartDataSet) {
//    dataSet.lineDashLengths = nil
//    dataSet.highlightLineDashLengths = nil
//    dataSet.setColors(.black, .red, .white)
    dataSet.setCircleColor(.green)
    dataSet.gradientPositions = [0, 40, 100]
    dataSet.lineWidth = 4
//    dataSet.circleRadius = 8
//    dataSet.drawCircleHoleEnabled = false
    
    dataSet.valueFont = .systemFont(ofSize: 12)
    
    
  
//    dataSet.valueFont = .systemFont(ofSize: 9)
//    dataSet.formLineDashLengths = nil
//    dataSet.formLineWidth = 1
//    dataSet.formSize = 15
    
//    if dataSet.isDrawLineWithGradientEnabled {
//      dataSet.lineDashLengths = nil
//      dataSet.highlightLineDashLengths = nil
//      dataSet.setColors(.black, .red, .white)
//      dataSet.setCircleColor(.black)
//      dataSet.gradientPositions = [0, 40, 100]
//      dataSet.lineWidth = 1
//      dataSet.circleRadius = 3
//      dataSet.drawCircleHoleEnabled = false
//      dataSet.valueFont = .systemFont(ofSize: 9)
//      dataSet.formLineDashLengths = nil
//      dataSet.formLineWidth = 1
//      dataSet.formSize = 15
//    } else {
//      dataSet.lineDashLengths = [5, 2.5]
//      dataSet.highlightLineDashLengths = [5, 2.5]
//      dataSet.setColor(.black)
//      dataSet.setCircleColor(.black)
//      dataSet.gradientPositions = nil
//      dataSet.lineWidth = 1
//      dataSet.circleRadius = 3
//      dataSet.drawCircleHoleEnabled = false
//      dataSet.valueFont = .systemFont(ofSize: 9)
//      dataSet.formLineDashLengths = [5, 2.5]
//      dataSet.formLineWidth = 1
//      dataSet.formSize = 15
//    }
  }

  
}
