//
//  PriceTableViewHeader.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/27/23.
//

import UIKit


class PriceTableViewHeader: UIView {
  
  
  // MARK: - Properties
  
  var priceLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .left
    newLabel.text = NSLocalizedString("Price", comment: "")
    newLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var amountLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .left
    newLabel.text = NSLocalizedString("Amount", comment: "")
    newLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
  
  lazy var viewModel = {
    TableViewHeaderViewModel()
  }()
  
  
  // MARK: - init Methods
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init(frame: CGRect, for priceType: PriceType) {
    self.init(frame: frame)
    addViews()
  }
  
  
  // MARK: - Startup Methods
  
  func addViews() {
    
    addSubview(priceLabel)
    addSubview(amountLabel)
    
    addSubview(labelStack)
    
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(amountLabel)
    
    let constraints = [
      labelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      labelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      labelStack.topAnchor.constraint(equalTo: topAnchor),
      labelStack.bottomAnchor.constraint(equalTo: bottomAnchor),
      labelStack.setHeightContraint(by: 40)
    ]
    NSLayoutConstraint.activate(constraints)

  }
  
  
  
}
