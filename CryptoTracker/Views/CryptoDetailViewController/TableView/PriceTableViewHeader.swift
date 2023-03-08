/*
 PriceTableViewHeader.swift
 
 Created by Cristina Dobson
 */

import UIKit


class PriceTableViewHeader: UIView {
  
  
  // MARK: - Properties
  
  var priceLabel: UILabel!
  var amountLabel: UILabel!
  var labelStack: UIStackView!
  
  
  // MARK: - Info Button Callback
  
  var infoButtonPressed: (() -> Void) = {}
  
  
  // MARK: - Init Methods
  
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
     LabelStack
     */
    
    let priceLabelContainer = ViewHelper.createEmptyView()
    priceLabel = getLabel(
      text: NSLocalizedString("Price", comment: ""))
    
    amountLabel = getLabel(
      text: NSLocalizedString("Amount", comment: ""))
    
    labelStack = getStackView()
    
    // Add the labels and stack to the current view.
    priceLabelContainer.addSubview(priceLabel)
    addSubview(priceLabelContainer)
    addSubview(amountLabel)
    addSubview(labelStack)
    
    // Arrange the labels on the LabelStack.
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
    
    // Add an Info Button on top of the LabelStack
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
  
  
  // MARK: - UI Helper Methods
  
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
  
  /*
   Send a callback to CryptoDetailViewController
   that the Info Button has been tapped.
   */
  @objc func buttonInfoAction() {
    infoButtonPressed()
  }
  
}
