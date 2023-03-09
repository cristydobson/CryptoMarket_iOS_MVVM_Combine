/*
 CryptoCollectionView.swift
 
 The collection view to display all the
 crypto currencies returned by the API.
 
 Created by Cristina Dobson
 */


import UIKit
import Combine


class CryptoCollectionView: UIView {

  
  // MARK: - Parent Controller
  
  /*
   To trigger the segue to CryptoDetailViewController
   when a cell is tapped on.
   */
  private var controller: UIViewController!
  
  
  // MARK: - Properties
  
  var collectionView: UICollectionView!
  var cellID = "CollectionCell"
  private var subscriptions = Set<AnyCancellable>()
  
  
  // MARK: - View Model
  
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
    
    setupBindings()
    loadViewModel()
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .clear
  }
  
  // Setup the collection view
  func setupCollectionView() {
    
    let horizontalInsets: CGFloat = 40
    let viewWidth = frame.width
    
    // Cell Size
    let cellsPerRow: CGFloat = 3
    let totalHorizontalInsets = horizontalInsets + cellsPerRow
    let cellWidth = (viewWidth - totalHorizontalInsets) / cellsPerRow
    
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
  
  /*
   Setup the callback to reload the collection view
   from the ViewModel
   */
  func loadViewModel() {
    viewModel.fetchData()
  }
  
  func setupBindings() {
    
    viewModel.$cryptoCellViewModels.sink { [weak self] _ in
      // Update the UI on the main thread
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    }.store(in: &subscriptions)
  }
  
  
  // MARK: - Timer
  
  /*
   Manage the timer in the ViewModel to
   refresh the data.
   */
  
  func startTimer() {
    viewModel.startTimer()
  }
  
  func stopTimer() {
    viewModel.cancelTimer()
  }
  
  
  // MARK: - Segue to Details View
  
  /*
   Trigger the segue to CryptoDetailViewController on
   the parent ViewController
   */
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
  
  // Animate the highlighting of the cell when tapped on.
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

// The timer has triggered a refresh of the data.
extension CryptoCollectionView: CryptoCollectionViewModelDelegate {
  
  func reloadCollectionData() {
    loadViewModel()
  }
  
}
