//
//  CryptoCollectionView.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class CryptoCollectionView: UIView {
  
  
  // MARK: - Properties
  var collectionView: UICollectionView!
  var cellID = "CollectionCell"
  
  lazy var viewModel = {
    CryptoCollectionViewModel()
  }()
  
  
  // MARK: - Init methods
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemBackground
    
    setupCollectionView()
    initViewModel()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Startup Methods
  func setupCollectionView() {
    
    // CollectionView Layout
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    layout.itemSize = CGSize(width: 60, height: 60)
    
    // Instantiate CollectionView
    collectionView = UICollectionView(frame: frame,
                                      collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    
    // Register the CollectionView's cell
    collectionView.register(UICollectionViewCell.self,
                            forCellWithReuseIdentifier: cellID)
    
    // Add CollectionView to current View
    addSubview(collectionView)
    
  }
  
  // Initialize CollectionViewModel
  func initViewModel() {
    
    viewModel.getCryptoData()
    
    viewModel.reloadCollectionView = { [weak self] in
      // Update the UI on the main thread
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
  }
  
}


// MARK: - UICollectionViewDataSource

extension CryptoCollectionView: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.cryptoCellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID,
                                                  for: indexPath)
    cell.backgroundColor = .blue
    return cell
  }
  
}


// MARK: - UICollectionViewDelegate

extension CryptoCollectionView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("DID TAP CELL!!!!")
  }
  
}
