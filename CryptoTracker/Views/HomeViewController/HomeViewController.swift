//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class HomeViewController: UIViewController {
  
  
  // MARK: - Properties
  
  
  

  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = NSLocalizedString("Crypto Tracker",
                              comment: "")
    
    view.backgroundColor = .red
    
    setupCollectionView()
  }
  
  
  // MARK: - Startup Methods
  
  func setupCollectionView() {
    let collectionView = CryptoCollectionView(frame: view.frame)
    view.addSubview(collectionView)
  }


}

