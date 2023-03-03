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
//    let newLabel = ViewHelper.createLabel(with: .white, text: "$0.00",
//                                          alignment: .center,
//                                          font: UIFont.systemFont(ofSize: 16))
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.text = "$0.00"
    newLabel.textAlignment = .center
    newLabel.font = UIFont.systemFont(ofSize: 16)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var amountLabel: UILabel = {
//    let newLabel = ViewHelper.createLabel(with: .white, text: "0.00000",
//                                          alignment: .center,
//                                          font: UIFont.systemFont(ofSize: 16))
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.text = "0.00000"
    newLabel.textAlignment = .center
    newLabel.font = UIFont.systemFont(ofSize: 16)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  let labelStack: UIStackView = {
//    let stackView = ViewHelper.createStackView(.horizontal,
//                                               distribution: .fillEqually,
//                                               spacing: 0)
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .center
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
    
    NSLayoutConstraint.activate([
      labelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      labelStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      labelStack.topAnchor.constraint(equalTo: topAnchor),
      labelStack.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
  }
  
}
