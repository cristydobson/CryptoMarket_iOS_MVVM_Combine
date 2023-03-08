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
  
  
  // MARK: - Info Button
  
  var infoButtonPressed: (() -> Void) = {}
  
  
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
    
    /*
     Label Stack
     */
    
    let priceLabelContainer = ViewHelper.createEmptyView()
    
    priceLabel = getLabel(
      text: NSLocalizedString("Price", comment: ""))
    amountLabel = getLabel(
      text: NSLocalizedString("Amount", comment: ""))
    
    labelStack = getStackView()
    
    priceLabelContainer.addSubview(priceLabel)
    addSubview(priceLabelContainer)
    addSubview(amountLabel)
    addSubview(labelStack)
    
    labelStack.addArrangedSubview(priceLabelContainer)
    labelStack.addArrangedSubview(amountLabel)

    NSLayoutConstraint.activate([
      // Price Label
      priceLabel.topAnchor.constraint(
        equalTo: priceLabelContainer.topAnchor),
      priceLabel.bottomAnchor.constraint(
        equalTo: priceLabelContainer.bottomAnchor),
      priceLabel.centerXAnchor.constraint(
        equalTo: priceLabelContainer.centerXAnchor),
      
      // Label Stack
      labelStack.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      labelStack.trailingAnchor.constraint(
        equalTo: trailingAnchor),
      labelStack.topAnchor.constraint(
        equalTo: topAnchor),
      labelStack.bottomAnchor.constraint(
        equalTo: bottomAnchor)
    ])
    
    
    /*
     Info Button
     */
    
    let infoButton = getInfoButton()
    addSubview(infoButton)
    
    NSLayoutConstraint.activate([
      infoButton.leadingAnchor.constraint(
        equalTo: priceLabel.trailingAnchor, constant: 6),
      infoButton.topAnchor.constraint(
        equalTo: topAnchor),
      infoButton.bottomAnchor.constraint(
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
  
  
  // MARK: - Info Button Methods
  
  func getInfoButton() -> UIButton {
    let button = ViewHelper.createInfoButton()
    button.addTarget(self,
                     action: #selector(buttonInfoAction),
                     for: .touchUpInside)
    return button
  }
  
  @objc func buttonInfoAction() {
    infoButtonPressed()
  }
  
}
