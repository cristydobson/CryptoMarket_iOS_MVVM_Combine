//
//  CryptoCollectionCell.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class CryptoCollectionCell: UICollectionViewCell {
  
  
  // MARK: - Properties
  
  var imageView: UIImageView!
  var nameLabel: UILabel!
  var priceLabel: UILabel!
  var changeLabel: UILabel!
  var labelStack: UIStackView!
  
  
  var cellViewModel: CryptoCellViewModel? {
    didSet {
      
      let cryptoName = cellViewModel?.getCryptoNameString()
      
      imageView.image = ImageHelper.getCryptoIcon(for: cryptoName)
      
      nameLabel.text = cryptoName

      priceLabel.text = cellViewModel?.getPriceString()
      
      let changePercentage = cellViewModel?.getPricePercentageChangeString()
      changeLabel.text = changePercentage
      changeLabel.textColor = ColorHelper.getPercentageLabelColor(for: changePercentage!)
      
    }
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupCell()
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func setupCell() {
    backgroundColor = .darkestGrayAlpha
  }
  
  func addViews() {
    
    imageView = getImageView()
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(
        equalTo: topAnchor, constant: 24),
      imageView.widthAnchor.constraint(
        equalToConstant: frame.width/2.7),
      imageView.heightAnchor.constraint(
        equalToConstant: frame.width/2.7),
      imageView.centerXAnchor.constraint(
        equalTo: centerXAnchor)
    ])
    
    // Stack View
    nameLabel = getLabel(fontSize: 20, weigth: .bold)
    priceLabel = getLabel(fontSize: 16, weigth: .regular)
    changeLabel = getLabel(fontSize: 16, weigth: .regular)
    labelStack = getStackView()
    
    addSubview(nameLabel)
    addSubview(priceLabel)
    addSubview(changeLabel)
    addSubview(labelStack)

    labelStack.addArrangedSubview(nameLabel)
    labelStack.addArrangedSubview(priceLabel)
    labelStack.addArrangedSubview(changeLabel)
    
    NSLayoutConstraint.activate([
      labelStack.topAnchor.constraint(
        equalTo: imageView.bottomAnchor, constant: 8),
      labelStack.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: 8),
      labelStack.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -8),
      bottomAnchor.constraint(
        greaterThanOrEqualTo: labelStack.bottomAnchor, constant: 0)
    ])

  }
  
  func getLabel(fontSize: CGFloat, weigth: UIFont.Weight) -> UILabel {
    let newLabel = ViewHelper.createLabel(
      with: .white, text: "", alignment: .center,
      font: UIFont.systemFont(ofSize: fontSize, weight: weigth))
    return newLabel
  }
  
  func getStackView() -> UIStackView {
    let stackView = ViewHelper.createStackView(
      .vertical, distribution: .fill)
    stackView.spacing = 2
    return stackView
  }
  
  func getImageView() -> UIImageView {
    let imageView = ViewHelper.createImageView()
    return imageView
  }
  
}
