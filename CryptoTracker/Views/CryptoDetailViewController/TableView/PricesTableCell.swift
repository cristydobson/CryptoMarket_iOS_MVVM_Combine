//
//  PricesTableCell.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import UIKit


class PricesTableCell: UITableViewCell {
  
  
  // MARK: - Properties
  
  var priceLabel: UILabel!
  var amountLabel: UILabel!
  var labelStack: UIStackView!
  
  var cellViewModel: PriceCellViewModel? {
    didSet {
      priceLabel.text = cellViewModel?.getPriceString()
      priceLabel.textColor = cellViewModel?.getPriceLabelColor()
      
      amountLabel.text = cellViewModel?.getAmountString()
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupCell()
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func setupCell() {
    selectionStyle = .none
    backgroundColor = .clear
  }
  
  func addViews() {
    
    // Label stack
    priceLabel = getLabel(text: "0.000000")
    amountLabel = getLabel(text: "0.00000")
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
      with: .white, text: text, alignment: .center,
      font: UIFont.systemFont(ofSize: 16))
    return newLabel
  }
  
  func getStackView() -> UIStackView {
    let stackView = ViewHelper.createStackView(
      .horizontal, distribution: .fillEqually)
    return stackView
  }
  
}
