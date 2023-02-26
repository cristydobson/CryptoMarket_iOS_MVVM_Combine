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
  
  var timeSpanLabelContainerView: UIView = {
    let newView = UIView()
    newView.frame.size.height = 300
    newView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//    newView.layer.cornerRadius = 15
//    newView.layer.masksToBounds = true
    return newView
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
    
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
//    fatalError("init(coder:) has not been implemented!!")
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
//    timeSpanLabelContainerView.addSubview(timeSpanLabel)
    addSubview(timeSpanLabelContainerView)
    addSubview(priceLabel)
    addSubview(changeLabel)
    addSubview(labelStack)
    
//    timeSpanLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
//    timeSpanLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
//    timeSpanLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
//    timeSpanLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true

    labelStack.addArrangedSubview(nameLabel)
    labelStack.addArrangedSubview(timeSpanLabelContainerView)
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(changeLabel)
    
    labelStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
    labelStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
    labelStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    
    

  }
  
  // TODO: - Change to ViewModel (return color)
  func setChangePercentageLabelColor(for amount: String) {
    changeLabel.textColor = amount.contains("-") ? .red : .green
  }
  
  
}
