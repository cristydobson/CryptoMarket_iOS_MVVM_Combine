//
//  ViewHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/28/23.
//

import Foundation
import UIKit

extension UIView {
  
  // MARK: - Constraining Methods
    
  func setConstraintsToBounds(ofSuperview view: UIView) -> [NSLayoutConstraint] {
    return [
      topAnchor.constraint(equalTo: view.topAnchor),
      leadingAnchor.constraint(equalTo: view.leadingAnchor),
      view.bottomAnchor.constraint(equalTo: bottomAnchor),
      view.trailingAnchor.constraint(equalTo: trailingAnchor)
    ]
  }
  
  func setHeightContraint(by constant: CGFloat) -> NSLayoutConstraint {
    return heightAnchor.constraint(equalToConstant: constant)
  }
  
  func setWidthContraint(by constant: CGFloat) -> NSLayoutConstraint {
    return widthAnchor.constraint(equalToConstant: constant)
  }
  
}


struct ViewHelper {
  
  static func createLabel(with color: UIColor, text: String, alignment: NSTextAlignment, font: UIFont) -> UILabel {
    
    let newLabel = UILabel()
    newLabel.textColor = color
    newLabel.text = text
    newLabel.textAlignment = alignment
    newLabel.font = font
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }
  
  static func createStackView(_ axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, spacing: CGFloat) -> UIStackView {
    
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = distribution
    stackView.spacing = spacing
    stackView.translatesAutoresizingMaskIntoConstraints = true
    return stackView
  }
  
}

