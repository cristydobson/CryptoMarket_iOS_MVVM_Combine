/*
 HomeViewController.swift
 
 Display the HomeScreen with a collectionView
 of crypto currencies.
 
 Created by Cristina Dobson
 */


import UIKit


class HomeViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var collectionView: CryptoCollectionView!
  var loadingView: LoadingScreenView!
  

  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    // Start the timer to refresh the data.
    collectionView.startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Stop the timer that refreshes the data.
    collectionView.stopTimer()
  }
  
  
  // MARK: - Setup UI Methods
  
  func setupView() {
    view.addGradientBackground()
    
    setupCollectionView()
    setupScreenTitle()
    
    setupLoadingView()
  }
  
  // Setup the main collection view
  func setupCollectionView() {
    collectionView = CryptoCollectionView(
      frame: view.frame, controller: self)
    view.addSubview(collectionView)
  }
  
  /*
   Add the HomeScreen title with a background view
   to the NavigationBar.
   */
  func setupScreenTitle() {
    
    let titleContainerHorizontalPadding: CGFloat = 18
    let titleContainerVerticalPadding: CGFloat = 6
    
    let titleContainerView = getTitleContainerView()
    let titleLabel = getTitleLabel()
    
    titleContainerView.addSubview(titleLabel)
    
    navigationController?.navigationBar.addSubview(titleContainerView)
    
    NSLayoutConstraint.activate([
      // Title Background View
      titleContainerView.centerXAnchor.constraint(equalTo: (navigationController?.navigationBar.centerXAnchor)!),
      
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
  
  
  // MARK: - UI Helper Methods
  
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
  
  
  // MARK: - Loading View
  
  /*
   Display a Loading View while
   the app fully loads
   */
  func setupLoadingView() {
    
    loadingView = getLoadingView()
    view.addSubview(loadingView)
    
    NSLayoutConstraint.activate([
      loadingView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor),
      loadingView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor),
      loadingView.topAnchor.constraint(
        equalTo: view.topAnchor),
      loadingView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor)
    ])
    
    // Remove it after a given waiting time
    Timer.scheduledTimer(
      timeInterval: 4,
      target: self,
      selector: #selector(dismissLoadingView),
      userInfo: nil,
      repeats: false)
    
  }
  
  // Create the Loading View
  func getLoadingView() -> LoadingScreenView {
    let loadView = UINib(nibName: "LoadingScreenView", bundle: nil)
      .instantiate(withOwner: nil)[0] as! LoadingScreenView
    
    loadView.translatesAutoresizingMaskIntoConstraints = false
    return loadView
  }
  
  // Action to remove the Loading View
  @objc func dismissLoadingView() {
    loadingView.removeFromSuperview()
    loadingView = nil
  }
  
}


