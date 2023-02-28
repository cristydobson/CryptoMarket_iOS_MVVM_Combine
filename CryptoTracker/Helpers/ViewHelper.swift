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
