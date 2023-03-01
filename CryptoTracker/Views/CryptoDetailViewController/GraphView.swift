//
//  GraphView.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/28/23.
//

import UIKit
import Charts


class GraphView: UIView {
  
  
  // MARK: - Properties
  
  var chartView: LineChartView!
  
  lazy var viewModel = {
    GraphViewModel()
  }()
  
    
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .black
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func addChartView() {
    let chartRect = CGRect(origin: CGPoint.zero,
                           size: frame.size)
    
    chartView = LineChartView(frame: chartRect)
    
    chartView.chartDescription.enabled = false
    
    chartView.backgroundColor = .black
    chartView.tintColor = .white
    
    let xAxis = chartView.xAxis
    xAxis.labelPosition = .bottom
    chartView.rightAxis.enabled = false
    
    
    
    
    addSubview(chartView)
    
    
    
    
  }

  
  // MARK: - Load View Model
  func loadViewModel(with prices: [CryptoPrice]) {
    viewModel.startViewModel(with: prices, andGraph: frame.size)
    updateChart()
  }
  
}


// MARK: - Chart View

extension GraphView {
  
  func updateChart() {
    
    if chartView == nil { addChartView() }
    else { chartView.data = nil }
    
    chartView.data = viewModel.getChartData()
  }
  
}
