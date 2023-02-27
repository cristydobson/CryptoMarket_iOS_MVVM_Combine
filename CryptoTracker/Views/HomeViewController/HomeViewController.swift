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
    
    title = NSLocalizedString("Crypto Tracker",
                              comment: "")
    
    view.addGradientBackground()
    
    setupCollectionView()
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
  
  
}

