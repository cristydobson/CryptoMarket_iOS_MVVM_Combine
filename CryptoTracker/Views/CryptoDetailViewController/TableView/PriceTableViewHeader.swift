//
//  PriceTableViewHeader.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/27/23.
//

import UIKit


class PriceTableViewHeader: UIView {
  
  
  // MARK: - Properties
  
  var priceLabel: UILabel!
  var amountLabel: UILabel!
  var labelStack: UIStackView!
  
  
  // MARK: - init Methods
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func addViews() {
    
    priceLabel = getLabel(
      text: NSLocalizedString("Price", comment: ""))
    amountLabel = getLabel(
      text: NSLocalizedString("Amount", comment: ""))
    
    labelStack = getStackView()
    
    addSubview(priceLabel)
    addSubview(amountLabel)
    addSubview(labelStack)
    
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(amountLabel)
    
    NSLayoutConstraint.activate([
      labelStack.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      labelStack.trailingAnchor.constraint(
        equalTo: trailingAnchor),
      labelStack.topAnchor.constraint(
        equalTo: topAnchor),
      labelStack.bottomAnchor.constraint(
        equalTo: bottomAnchor)
    ])

  }
  
  func getLabel(text: String) -> UILabel {
    let newLabel = ViewHelper.createLabel(
      with: .white, text: text,
      alignment: .center,
      font: UIFont.systemFont(ofSize: 16, weight: .semibold))
    return newLabel
  }
  
  func getStackView() -> UIStackView {
    let stackView = ViewHelper.createStackView(
      .horizontal, distribution: .fillEqually)
    return stackView
  }
  
}
