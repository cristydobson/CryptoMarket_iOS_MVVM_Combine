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
    let newLabel = ViewHelper.createLabel(with: .white, text: "",
                                          alignment: .left,
                                          font: UIFont.systemFont(ofSize: 22, weight: .semibold))
    return newLabel
  }()
  
  var priceLabel: UILabel = {
    let newLabel = ViewHelper.createLabel(with: .white, text: "",
                                          alignment: .left,
                                          font: UIFont.systemFont(ofSize: 18, weight: .medium))
    return newLabel
  }()
  
  var priceTitleLabel: UILabel = {
    let newLabel = ViewHelper
      .createLabel(with: .darkGray,
                   text: NSLocalizedString("Last Trade", comment: ""),
                   alignment: .left,
                   font: UIFont.systemFont(ofSize: 14, weight: .medium))
    return newLabel
  }()
  
  var changeLabel: UILabel = {
    let newLabel = ViewHelper.createLabel(with: .white, text: "+0.00%",
                                          alignment: .left,
                                          font: UIFont.systemFont(ofSize: 18, weight: .medium))
    return newLabel
  }()
  
  var changeTitleLabel: UILabel = {
    let newLabel = ViewHelper.createLabel(with: .darkGray,
                                          text: NSLocalizedString("24h Price", comment: ""),
                                          alignment: .left,
                                          font: UIFont.systemFont(ofSize: 14, weight: .medium))
    return newLabel
  }()
  
  let priceStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  
  // MARK: - View Model
  
  var viewModel: HeaderViewModel? {
    didSet {
      setupViews()
    }
  }
  
  func setupViews() {
    nameLabel.text = viewModel?.name
    imageView.image = viewModel?.getImage()
    priceLabel.text = viewModel?.getPriceString()
    
    let changeString = viewModel?.getPricePercentageChangeString()
    changeLabel.text = changeString
    changeLabel.textColor = ColorHelper.getPercentageLabelColor(for: changeString!)
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
    
    /*
     Icon Image View
     */
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
//      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      imageView.heightAnchor.constraint(equalToConstant: 40),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
      imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
    
    
    /*
     Name Label
     */
    addSubview(nameLabel)
    
    let nameConstraints = [
      nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
      nameLabel.bottomAnchor.constraint(equalTo: imageView.lastBaselineAnchor, constant: -4)
    ]
    NSLayoutConstraint.activate(nameConstraints)
    
    
    /*
     Price Stack
     */
    
    let priceLabelStack = getVerticalStack()
    
    addSubview(priceLabel)
    addSubview(priceTitleLabel)
    addSubview(priceLabelStack)
    priceLabelStack.addArrangedSubview(priceLabel)
    priceLabelStack.addArrangedSubview(priceTitleLabel)
    
    let changeLabelStack = getVerticalStack()
    
    addSubview(changeLabel)
    addSubview(changeTitleLabel)
    addSubview(changeLabelStack)
    changeLabelStack.addArrangedSubview(changeLabel)
    changeLabelStack.addArrangedSubview(changeTitleLabel)
    
    addSubview(priceStack)
    priceStack.addArrangedSubview(priceLabelStack)
    priceStack.addArrangedSubview(changeLabelStack)
    
    NSLayoutConstraint.activate([
      // Price Stack
      priceStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      priceStack.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
    ])

  }
  
  func getVerticalStack() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    stackView.spacing = 2
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }
  
}
