//
//  CryptoCollectionView.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class CryptoCollectionView: UIView {
  
  
  // MARK: - Parent Controller
  
  private var controller: UIViewController!
  
  
  // MARK: - Properties
  
  var collectionView: UICollectionView!
  var cellID = "CollectionCell"
  
  lazy var viewModel = {
    CryptoCollectionViewModel()
  }()
  
  
  // MARK: - Init methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init(frame: CGRect, controller: UIViewController) {
    self.init(frame: frame)
    self.controller = controller
    
    setupView()
    setupCollectionView()
    
    viewModel.delegate = self
    loadViewModel()
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .clear
  }
  
  func setupCollectionView() {
    
    let horizontalInsets: CGFloat = 40
    let viewWidth = frame.width
    
    // Cell Size
    let cellsPerRow: CGFloat = 3
    let cellWidth = (viewWidth - (horizontalInsets + cellsPerRow)) / cellsPerRow
    
    // CollectionView Layout
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(
      top: 34, left: horizontalInsets/2,
      bottom: 0, right: horizontalInsets/2)
    layout.minimumInteritemSpacing = 1
    layout.minimumLineSpacing = 1
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth*1.3)
    
    // Instantiate CollectionView
    collectionView = UICollectionView(
      frame: frame, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.delegate = self
    
    // Register the CollectionView's cell
    collectionView.register(CryptoCollectionCell.self,
                            forCellWithReuseIdentifier: cellID)
    
    // Add CollectionView to current View
    addSubview(collectionView)
    
  }
  
  // Initialize CollectionViewModel
  func loadViewModel() {
    
    viewModel.fetchData()
    
    viewModel.reloadCollectionView = { [weak self] in
      // Update the UI on the main thread
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }
  }
  
  func startTimer() {
    viewModel.startTimer()
  }
  
  func stopTimer() {
    viewModel.cancelTimer()
  }
  
  
  // MARK: - Segue to Details View
  
  func createSegueToDetailViewController(for indexPath: IndexPath) {
    let detailViewController = CryptoDetailViewController()
    detailViewController.cryptoSymbol = viewModel.cryptoCellViewModels[indexPath.row].symbol ?? ""
    controller.navigationController?.pushViewController(detailViewController, animated: true)
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
                                                  for: indexPath) as! CryptoCollectionCell
    let cellViewModel = viewModel.getCellViewModel(at: indexPath)
    cell.cellViewModel = cellViewModel
    return cell
  }
  
}


// MARK: - UICollectionViewDelegate

extension CryptoCollectionView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    createSegueToDetailViewController(for: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    
    if let cell = collectionView.cellForItem(at: indexPath) {
      
      UIView.animate(withDuration: 0.2, animations: {
        cell.alpha = 0.5
      }) { (_) in
        UIView.animate(withDuration: 0.2) {
          cell.alpha = 1.0
        }
      }
    }
    return true
  }
  
}


// MARK: - CryptoCollectionViewModelDelegate

extension CryptoCollectionView: CryptoCollectionViewModelDelegate {
  
  func reloadCollectionData() {
    loadViewModel()
  }
  
}
