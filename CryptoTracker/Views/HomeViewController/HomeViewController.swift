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
    
    view.addGradientBackground()
    
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
  
  
  // MARK: - Startup Methods
  
  func setupCollectionView() {
    collectionView = CryptoCollectionView(frame: view.frame, controller: self)
    view.addSubview(collectionView)
  }
  
  func setupScreenTitle() {
    
    let titleContainerHorizontalPadding: CGFloat = 18
    let titleContainerVerticalPadding: CGFloat = 6
    
    let titleContainerView = UIView()
    titleContainerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    titleContainerView.layer.cornerRadius = 15
    titleContainerView.layer.masksToBounds = true
    
    let titleLabel = ViewHelper.createLabel(with: .white,
                                            text: NSLocalizedString("Crypto Market Tracker", comment: ""),
                                            alignment: .center,
                                            font: UIFont.boldSystemFont(ofSize: 22))
    
    titleContainerView.addSubview(titleLabel)
    view.addSubview(titleContainerView)
    view.bringSubviewToFront(titleContainerView)
    
    [titleContainerView, titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      // Title Container View
      titleContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
      titleContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      // Screen Title Label
      titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor,
                                          constant: titleContainerHorizontalPadding),
      titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor,
                                           constant: -titleContainerHorizontalPadding),
      titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor,
                                      constant: titleContainerVerticalPadding),
      titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor,
                                         constant: -titleContainerVerticalPadding)
    ])
    
  }
  
}


