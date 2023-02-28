//
//  CryptoCollectionCell.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class CryptoCollectionCell: UICollectionViewCell {
  
  
  // MARK: - Properties
  
  var imageView: UIImageView = {
    let newImageView = UIImageView()
    newImageView.contentMode = .scaleAspectFit
    newImageView.backgroundColor = .clear
    newImageView.image = UIImage(named: "Bitcoin")
    newImageView.translatesAutoresizingMaskIntoConstraints = false
    return newImageView
  }()
  
  var nameLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .center
    newLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var priceLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .center
    newLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var changeLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textAlignment = .center
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  let labelStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  
  var cellViewModel: CryptoCellViewModel? {
    didSet {
      
      nameLabel.text = cellViewModel?.getCryptoNameString()

      priceLabel.text = cellViewModel?.getPriceString()
      
      let changePercentage = cellViewModel?.getPricePercentageChangeString()
      changeLabel.text = changePercentage
      setChangePercentageLabelColor(for: changePercentage!)
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
//    fatalError("init(coder:) has not been implemented!!")
  }
  
  
  // MARK: - Startup Methods
  func addViews() {
    
    addSubview(imageView)
    let imageConstraints = [
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      imageView.widthAnchor.constraint(equalToConstant: frame.width/2),
      imageView.heightAnchor.constraint(equalToConstant: frame.width/2),
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
    ]
    NSLayoutConstraint.activate(imageConstraints)
    
    // Stack View
    addSubview(nameLabel)
    addSubview(priceLabel)
    addSubview(changeLabel)
    addSubview(labelStack)

    labelStack.addArrangedSubview(nameLabel)
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(changeLabel)
    
    let labelStackConstraints = [
      labelStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
      labelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      labelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
    ]
    NSLayoutConstraint.activate(labelStackConstraints)

  }
  
  // TODO: - Change to ViewModel (return color)
  func setChangePercentageLabelColor(for amount: String) {
    changeLabel.textColor = amount.contains("-") ? .red : .green
  }
  
  
}
