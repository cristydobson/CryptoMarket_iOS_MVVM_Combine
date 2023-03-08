//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class HomeViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var collectionView: CryptoCollectionView!
  

  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupCollectionView()
    setupScreenTitle()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    collectionView.startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    collectionView.stopTimer()
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    view.addGradientBackground()
  }
  
  func setupCollectionView() {
    collectionView = CryptoCollectionView(
      frame: view.frame, controller: self)
    view.addSubview(collectionView)
  }
  
  func setupScreenTitle() {
    
    let titleContainerHorizontalPadding: CGFloat = 18
    let titleContainerVerticalPadding: CGFloat = 6
    
    let titleContainerView = getTitleContainerView()
    let titleLabel = getTitleLabel()
    
    titleContainerView.addSubview(titleLabel)
    view.addSubview(titleContainerView)
    view.bringSubviewToFront(titleContainerView)
    
    NSLayoutConstraint.activate([
      // Title Background View
      titleContainerView.topAnchor.constraint(
        equalTo: view.topAnchor, constant: 60),
      titleContainerView.centerXAnchor.constraint(
        equalTo: view.centerXAnchor),
      
      // Screen Title Label
      titleLabel.leadingAnchor.constraint(
        equalTo: titleContainerView.leadingAnchor,
        constant: titleContainerHorizontalPadding),
      titleLabel.trailingAnchor.constraint(
        equalTo: titleContainerView.trailingAnchor,
        constant: -titleContainerHorizontalPadding),
      titleLabel.topAnchor.constraint(
        equalTo: titleContainerView.topAnchor,
        constant: titleContainerVerticalPadding),
      titleLabel.bottomAnchor.constraint(
        equalTo: titleContainerView.bottomAnchor,
        constant: -titleContainerVerticalPadding)
    ])
    
  }
  
  func getTitleContainerView() -> UIView {
    let newView = ViewHelper.createEmptyView()
    newView.backgroundColor = .black
    newView.layer.cornerRadius = 15
    newView.layer.masksToBounds = true
    return newView
  }
  
  func getTitleLabel() -> UILabel {
    let newLabel = ViewHelper.createLabel(
      with: .white,
      text: NSLocalizedString("Crypto Market Tracker", comment: ""),
      alignment: .center, font: UIFont.boldSystemFont(ofSize: 22))
    return newLabel
  }
  
}


