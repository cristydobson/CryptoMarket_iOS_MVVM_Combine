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
    newLabel.textAlignment = .center
    newLabel.text = "$0.00"
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var amountLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .center
    newLabel.text = "0.00018"
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  let labelStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  var cellViewModel: PriceCellViewModel? {
    didSet {
      priceLabel.text = "\(cellViewModel?.price ?? 0.00)"
      priceLabel.textColor = cellViewModel?.getPriceLabelColor()
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .green
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
//    fatalError("init(coder:) has not been implemented!!")
  }
  
  
  func addViews() {
    
    // Label stack
    addSubview(priceLabel)
    addSubview(amountLabel)
    addSubview(labelStack)
    
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(amountLabel)
    
    labelStack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    labelStack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    labelStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
    labelStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
  }
  
  
  
}
