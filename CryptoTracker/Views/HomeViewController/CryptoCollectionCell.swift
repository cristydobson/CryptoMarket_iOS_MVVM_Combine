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
    newImageView.translatesAutoresizingMaskIntoConstraints = false
    return newImageView
  }()
  
  var nameLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .center
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var timeSpanLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .center
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  var priceLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.textAlignment = .center
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
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  
  var cellViewModel: CryptoCellViewModel? {
    didSet {
      imageView.image = UIImage(systemName: "star")
      
      nameLabel.text = cellViewModel?.getCryptoNameString()
      timeSpanLabel.text = NSLocalizedString("24h", comment: "")
      priceLabel.text = cellViewModel?.getPriceString()
      
      let changePercentage = cellViewModel?.getPricePercentageChangeString()
      changeLabel.text = changePercentage
      setChangePercentageLabelColor(for: changePercentage!)
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
//    backgroundColor = .blue
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented!!")
  }
  
  
  // MARK: - Startup Methods
  func addViews() {
    
    addSubview(imageView)
    imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: frame.width/2).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: frame.width/2).isActive = true
    imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    // Stack View
    addSubview(nameLabel)
    addSubview(timeSpanLabel)
    addSubview(priceLabel)
    addSubview(changeLabel)
    addSubview(labelStack)
    
    labelStack.addArrangedSubview(nameLabel)
    labelStack.addArrangedSubview(timeSpanLabel)
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(changeLabel)
    
    labelStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
    labelStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
    labelStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true

  }
  
  func setChangePercentageLabelColor(for amount: String) {
    changeLabel.textColor = amount.contains("-") ? .red : .green
  }
  
  
}
