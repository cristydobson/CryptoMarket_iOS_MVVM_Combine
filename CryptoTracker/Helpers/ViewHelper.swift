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
  
  func addGradientBackground() {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [
      UIColor.black.cgColor,
      UIColor.backgroundBlue.cgColor,
      UIColor.backgroundPurple.cgColor
    ]
    gradient.locations = [0.30, 0.70, 0.90, 1]
    layer.addSublayer(gradient)
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
  
}

