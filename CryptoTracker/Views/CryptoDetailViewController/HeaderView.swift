//
//  HeaderView.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 3/1/23.
//

import Foundation
import UIKit


class HeaderView: UIView {
  
  
  // MARK: - Properties
  
  var imageView: UIImageView = {
    let newImageView = UIImageView()
    newImageView.contentMode = .scaleAspectFit
    newImageView.backgroundColor = .clear
    newImageView.translatesAutoresizingMaskIntoConstraints = false
    return newImageView
  }()
  
  var nameLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.text = ""
    newLabel.textColor = .white
    newLabel.textAlignment = .left
    newLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var priceLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.text = ""
    newLabel.textColor = .red
    newLabel.textAlignment = .right
    newLabel.font = UIFont.systemFont(ofSize: 26, weight: .regular)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var viewModel: HeaderViewModel? {
    didSet {
      setupViews()
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    startViews()
    backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  
  // MARK: - Startup Methods
  
  func startViews() {
    addViews()
  }
  
  func addViews() {
    
    // Icon Image View
    addSubview(imageView)
    
    let imageViewConstraints = [
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
    ]
    NSLayoutConstraint.activate(imageViewConstraints)
    
    
    // Name Label
    addSubview(nameLabel)
    
    let nameConstraints = [
      nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
    ]
    NSLayoutConstraint.activate(nameConstraints)
    
    
    // Price Label
    addSubview(priceLabel)

    let priceLabelConstraints = [
      priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
    ]
    NSLayoutConstraint.activate(priceLabelConstraints)

  }
  
  func setupViews() {
    nameLabel.text = viewModel?.name
    imageView.image = viewModel?.getImage()
    priceLabel.text = viewModel?.getPriceString()
  }
  
  
  
}
