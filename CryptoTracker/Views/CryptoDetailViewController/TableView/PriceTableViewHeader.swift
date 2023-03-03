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
//    let newLabel = ViewHelper.createLabel(with: .white,
//                                          text: NSLocalizedString("Price", comment: ""),
//                                          alignment: .center,
//                                          font: UIFont.systemFont(ofSize: 16, weight: .semibold))
    
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.text = NSLocalizedString("Price", comment: "")
    newLabel.textAlignment = .center
    newLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var amountLabel: UILabel = {
//    let newLabel = ViewHelper.createLabel(with: .white,
//                                          text: NSLocalizedString("Amount", comment: ""),
//                                          alignment: .center,
//                                          font: UIFont.systemFont(ofSize: 16, weight: .semibold))
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.text = NSLocalizedString("Amount", comment: "")
    newLabel.textAlignment = .center
    newLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
//    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  lazy var viewModel = {
    TableViewHeaderViewModel()
  }()
  
  
  // MARK: - init Methods
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Startup Methods
  
  func addViews() {
    
    addSubview(priceLabel)
    addSubview(amountLabel)
    
    addSubview(labelStack)
    
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(amountLabel)
    
    NSLayoutConstraint.activate([
      // Label stack
      labelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      labelStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      labelStack.topAnchor.constraint(equalTo: topAnchor),
      labelStack.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

  }
  
  
  
}
