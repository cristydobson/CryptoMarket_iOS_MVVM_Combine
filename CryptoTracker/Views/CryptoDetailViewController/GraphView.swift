//
//  GraphView.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/28/23.
//

import UIKit


class GraphView: UIView {
  
  
  // MARK: - Properties
  
  var graphPathView: GraphPathAnimation!
  
  lazy var viewModel = {
    GraphViewModel()
  }()
  
    
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .blue
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  func addViews() {
    
  }
  
  func addGraphPathAnimation(with points: [CGPoint]?) {
    setupGraphAnimation(with: points)
    animateGraphPath()
  }
  
  
  // MARK: - Load View Model
  func loadViewModel(with prices: [CryptoPrice]) {
    viewModel.startViewModel(with: prices)
    addGraphPathAnimation(with: viewModel.graphPoints)
  }
  
}


// MARK: - Graph Path Animation

extension GraphView {

  func setupGraphAnimation(with points: [CGPoint]?) {
    
    graphPathView = GraphPathAnimation()

    graphPathView.setupAnimation(
      frame: frame,
      animatedLayerColor: .green,
      strokeWidth: 2,
      graphPoints: points,
      animated: true)

    addSubview(graphPathView)
  }

  func animateGraphPath() {

    graphPathView.animate(duration: 0.2) { finished in

      if finished {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          print("FINISHED ANIMATION!!!!!")
        }
      }
    }
  }

}
