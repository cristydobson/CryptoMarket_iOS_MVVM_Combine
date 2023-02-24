//
//  CryptoCollectionCell.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class CryptoCollectionCell: UICollectionViewCell {
  
  
  // MARK: - Properties
  
  var nameLabel: UILabel = {
    let newLabel = UILabel()
    newLabel.textColor = .white
    newLabel.translatesAutoresizingMaskIntoConstraints = false
    return newLabel
  }()
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented!!")
  }
  
  
  // MARK: - Startup Methods
  func addViews() {
    addSubview(nameLabel)
    
    nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
    nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
    nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
  }
  
  
}
