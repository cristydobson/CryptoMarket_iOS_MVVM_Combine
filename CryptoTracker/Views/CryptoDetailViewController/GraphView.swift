/*
 GraphView.swift
 
 Display the given data points in the graph.
 
 Created by Cristina Dobson
 */


import UIKit
import Charts


class GraphView: UIView {
  
  
  // MARK: - Properties
  
  var chartView: LineChartView!
  
  
  // MARK: - View Model
  
  lazy var viewModel = {
    GraphViewModel()
  }()
  
    
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .black
    isUserInteractionEnabled = false
  }
  
  // Initialiaze the Graph / Chart
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
    viewModel.startViewModel(with: prices)
    updateChart()
  }
  
}


// MARK: - Update Chart View

extension GraphView {
  
  func updateChart() {
    
    if chartView == nil { addChartView() }
    else { chartView.data = nil }
    
    chartView.data = viewModel.getChartData()
  }
  
}
