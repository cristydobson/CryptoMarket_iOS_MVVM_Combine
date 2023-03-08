/*
 ViewHelper.swift
 
 Created by Cristina Dobson
 */


import Foundation
import UIKit


// MARK: - UIView Extension

extension UIView {
  
  // Constraining Methods
  func setHeightContraint(by constant: CGFloat) -> NSLayoutConstraint {
    return heightAnchor.constraint(equalToConstant: constant)
  }
  
  func setWidthContraint(by constant: CGFloat) -> NSLayoutConstraint {
    return widthAnchor.constraint(equalToConstant: constant)
  }
  
  // Add a gradient color to the background view
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


// MARK: - View Helper

struct ViewHelper {
  
  // Create a Label
  static func createLabel(with color: UIColor, text: String, alignment: NSTextAlignment, font: UIFont) -> UILabel {
    
    let newLabel = UILabel()
    newLabel.textColor = color
    newLabel.text = text
    newLabel.textAlignment = alignment
    newLabel.font = font
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    newLabel.adjustsFontSizeToFitWidth = true
    return newLabel
  }
  
  // Create a Stack View
  static func createStackView(_ axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = axis
    stackView.distribution = distribution
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }
  
  // Create an empty UIView
  static func createEmptyView() -> UIView {
    let newView = UIView()
    newView.translatesAutoresizingMaskIntoConstraints = false
    return newView
  }
  
  // Create an ImageView
  static func createImageView() -> UIImageView {
    let newImageView = UIImageView()
    newImageView.contentMode = .scaleAspectFit
    newImageView.backgroundColor = .clear
    newImageView.translatesAutoresizingMaskIntoConstraints = false
    return newImageView
  }
  
  // Create an Info Button
  static func createInfoButton() -> UIButton {
    let button = UIButton()
    button.setImage(UIImage(systemName: "info.circle.fill"),
                    for: .normal)
    button.tintColor = .infoButtonWhite
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }
  
}

