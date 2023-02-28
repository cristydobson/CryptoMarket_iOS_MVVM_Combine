//
//  GraphPathAnimation.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/28/23.
//

import UIKit

class GraphPathAnimation: UIView, CAAnimationDelegate {
  
  
  // MARK: - Properties
  
  private var graphPoints: [CGPoint] = []
  
  private var animatedLayerColor: UIColor = UIColor.green {
    didSet {
      animatedLayer?.strokeColor = animatedLayerColor.cgColor
    }
  }
  
  private var strokeWidth: CGFloat = 8 {
    didSet {
      animatedLayer?.lineWidth = strokeWidth
    }
  }
  
  private var animated: Bool = true {
    didSet {
      if animated {
        animatedLayer = createPathLayer(strokeColor: animatedLayerColor,
                                        strokeEnd: 0,
                                        with: graphPoints)
        layer.addSublayer(animatedLayer!)
      }
    }
  }
  
  private var animatedLayer: CAShapeLayer?
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .darkGray
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func setupAnimation(frame: CGRect, animatedLayerColor: UIColor, strokeWidth: CGFloat, graphPoints: [CGPoint], animated: Bool) {
    self.frame = frame
    self.animatedLayerColor = animatedLayerColor
    self.strokeWidth = strokeWidth
    self.graphPoints = graphPoints
    self.animated = animated
  }
  
}


// MARK: - Create CAShapeLayer
extension GraphPathAnimation {
  
  private func createPathLayer(strokeColor: UIColor, strokeEnd: CGFloat, with points: [CGPoint]) -> CAShapeLayer {

    // Draw graph path
    let graphPath = UIBezierPath()
    graphPath.move(to: points[0])
  
    for i in 1..<points.count {
      graphPath.addLine(to: points[i])
    }
    
    // Create the graph path layer
    let graphPathLayer = CAShapeLayer()
    graphPathLayer.fillColor = UIColor.clear.cgColor
    graphPathLayer.lineWidth = strokeWidth
    graphPathLayer.path = graphPath.cgPath
    graphPathLayer.strokeEnd = strokeEnd
    graphPathLayer.strokeColor = strokeColor.cgColor
    graphPathLayer.lineCap = CAShapeLayerLineCap.square
    graphPathLayer.lineJoin = CAShapeLayerLineJoin.bevel
    
    return graphPathLayer
  }
  
}


// MARK: - Animate Layer

extension GraphPathAnimation {
  
  func animate(duration: TimeInterval = 0.6, completion: @escaping (Bool) -> Void) {
    
    guard let animatedLayer = animatedLayer else { return }
    
    let animation = CABasicAnimation(keyPath: AnimationKey.strokeEnd.rawValue)
    animation.delegate = self
    animation.fromValue = 0
    animation.toValue = 1
    animation.timingFunction = CAMediaTimingFunction(
      name: CAMediaTimingFunctionName.easeOut
    )
    animation.duration = duration
    animation.isRemovedOnCompletion = true
    
    animatedLayer.strokeEnd = 2
    animatedLayer.add(
      animation,
      forKey: AnimationKey.animateGraphPath.rawValue
    )
    
    completion(true)
  }
  
}
