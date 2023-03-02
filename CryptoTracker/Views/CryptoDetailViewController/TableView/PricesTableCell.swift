//
//  PricesTableCell.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import UIKit


class PricesTableCell: UITableViewCell {
  
  
  // MARK: - Properties
  
  var priceLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.text = "$0.00"
    newLabel.textAlignment = .left
    newLabel.font = UIFont.systemFont(ofSize: 16)
//    newLabel.backgroundColor = .red
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var amountLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.text = "0.00000"
    newLabel.textAlignment = .left
    newLabel.font = UIFont.systemFont(ofSize: 16)
//    newLabel.backgroundColor = .red
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  let labelStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 12
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
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
    selectionStyle = .none
    backgroundColor = .clear
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  func addViews() {
    
    // Label stack
    addSubview(priceLabel)
    addSubview(amountLabel)
    addSubview(labelStack)
    
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(amountLabel)
    
    let constraints = [
      labelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      labelStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      labelStack.topAnchor.constraint(equalTo: topAnchor),
      labelStack.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
    
  }
  
}
