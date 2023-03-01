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
  
//  var graphPathView: GraphPathAnimation!
  var chartView: LineChartView!
  
  
  lazy var viewModel = {
    GraphViewModel()
  }()
  
    
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .black
//    addViews()
//    addChartView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
//  func addViews() {
//
//  }
  
  func addChartView() {
    let chartRect = CGRect(origin: CGPoint.zero,
                           size: frame.size)
    
    chartView = LineChartView(frame: chartRect)
    addSubview(chartView)
    
    chartView.backgroundColor = .blue
    chartView.tintColor = .white
  }
  
//  func addGraphPathAnimation(with points: [CGPoint]) {
//    setupGraphAnimation(with: points)
//    animateGraphPath()
//  }
  
  
  // MARK: - Load View Model
  func loadViewModel(with prices: [CryptoPrice]) {
//    if graphPathView != nil { resetGraph() }
    
    viewModel.startViewModel(with: prices, andGraph: frame.size)
//    addGraphPathAnimation(with: viewModel.graphPoints)
    addChartView()
    updateChart(with: viewModel.graphPoints)
  }
  
}


// MARK: - Graph Path Animation

//extension GraphView {
//
//  func setupGraphAnimation(with points: [CGPoint]) {
//
//    graphPathView = GraphPathAnimation()
//
//    let graphViewFrame = CGRect(origin: CGPoint.zero, size: frame.size)
//
//    graphPathView.setupAnimation(
//      frame: graphViewFrame,
//      animatedLayerColor: .green,
//      strokeWidth: 2,
//      graphPoints: points,
//      animated: true)
//
//
//    addSubview(graphPathView)
//  }
//
//  func animateGraphPath() {
//
//    graphPathView.animate(duration: 0.2) { finished in
//
//      if finished {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//          print("FINISHED ANIMATION!!!!!")
//        }
//      }
//    }
//  }
//
//  func resetGraph() {
//    graphPathView.removeFromSuperview()
//    graphPathView = nil
//  }
//
//}


// MARK: - Setup Chart

extension GraphView {
  
  private func updateChart(with dataPoints: [CGPoint]) {
    
    chartView.data = viewModel.getChartData()
    
    chartView.chartDescription.text = "Ask Price Change"
    
  }
  
}
