//
//  CryptoDetailViewController.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/24/23.
//

import UIKit

class CryptoDetailViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var cryptoSymbol = ""
  
  
  // MARK: - Header View
  
  var headerView: HeaderView!
  
  
  // MARK: - Graph Properties
  
  var graphContainerView: GraphView!
  
  
  // MARK: - TableViews Properties
  
  var asksHeader: PriceTableViewHeader!
  var bidsHeader: PriceTableViewHeader!
  var asksTableView: PricesTableView!
  var bidsTableView: PricesTableView!
  
  
  // MARK: - View Model Property
  
  lazy var viewModel = {
    CryptoDetailViewModel()
  }()
  
  
  // MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    addViews()
    
    viewModel.delegate = self
    loadViewModel()
    
    asksHeader.infoButtonPressed = { //[weak self] in
      print("INFO BUTTON!!!!")
    }
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    navigationController?.navigationBar.topItem?.backButtonTitle = NSLocalizedString("Back", comment: "")
    
    view.backgroundColor = .black
  }
  
  func addViews() {

    let safeArea = view.safeAreaLayoutGuide
    let horizontalPadding: CGFloat = 48
    
    let viewWidth = view.frame.width
    let viewHeight = view.frame.height
    let viewHeightFraction = viewHeight/12
    
    // View Heights
    let headerViewHeight = viewHeightFraction * 1.2
    let graphViewHeight = viewHeightFraction * 5
    let tableHeaderHeight: CGFloat = 34
    let tableViewHeight = viewHeightFraction * 4.3
    
    // View Widths
    let tableViewWidth = (viewWidth - horizontalPadding) / 2
    
    
    /*
     Header View
     */
    setupHeaderView()
    view.addSubview(headerView)
  
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor),
      headerView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor),
      headerView.topAnchor.constraint(
        equalTo: safeArea.topAnchor),
      headerView.setHeightContraint(by: headerViewHeight)
    ])
    
    
    /*
     Graph Container View
     */
    setupGraphView()
    view.addSubview(graphContainerView)
    
    NSLayoutConstraint.activate([
      graphContainerView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor),
      graphContainerView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor),
      graphContainerView.topAnchor.constraint(
        equalTo: headerView.bottomAnchor,constant: 8),
      graphContainerView.setHeightContraint(by: graphViewHeight)
    ])
    

    /*
     TableView Header Stack
     */
    
    let tableHeaderContainerView = getEmptyView(color: .darkestGray)
    
    setupTableViewHeaders(
      with: CGSize(width: tableViewWidth,
                   height: tableHeaderHeight))
    
    let tableViewHeaderStack = getStackView()
    
    tableHeaderContainerView.addSubview(asksHeader)
    tableHeaderContainerView.addSubview(bidsHeader)
    tableHeaderContainerView.addSubview(tableViewHeaderStack)
    view.addSubview(tableHeaderContainerView)

    tableViewHeaderStack.addArrangedSubview(asksHeader)
    tableViewHeaderStack.addArrangedSubview(bidsHeader)
    
    NSLayoutConstraint.activate([
      // tableHeaderContainerView
      tableHeaderContainerView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor),
      tableHeaderContainerView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor),
      tableHeaderContainerView.topAnchor.constraint(
        equalTo: graphContainerView.bottomAnchor, constant: 24),
      tableHeaderContainerView.setHeightContraint(
        by: tableHeaderHeight),
      
      // TableView headers
      asksHeader.setWidthContraint(by: tableViewWidth),
      asksHeader.setHeightContraint(by: tableHeaderHeight),
      bidsHeader.setWidthContraint(by: tableViewWidth),
      bidsHeader.setHeightContraint(by: tableHeaderHeight),
      
      // TableView Header Container Stack
      tableViewHeaderStack.topAnchor.constraint(
        equalTo: tableHeaderContainerView.topAnchor),
      tableViewHeaderStack.bottomAnchor.constraint(
        equalTo: tableHeaderContainerView.bottomAnchor),
      tableViewHeaderStack.centerXAnchor.constraint(
        equalTo: tableHeaderContainerView.centerXAnchor),
    ])


    /*
     Price TableViews
     */
    
    // Container View
    let tableContainerView = getEmptyView(color: .clear)
    
    // Table Views
    setupTableViews(with: CGSize(width: tableViewWidth,
                                 height: tableViewHeight))
    
    let tableViewStack = getStackView()
    
    tableContainerView.addSubview(asksTableView)
    tableContainerView.addSubview(bidsTableView)
    tableContainerView.addSubview(tableViewStack)
    view.addSubview(tableContainerView)
    
    // Table View Container Stack
    tableViewStack.addArrangedSubview(asksTableView)
    tableViewStack.addArrangedSubview(bidsTableView)
    
    NSLayoutConstraint.activate([
      // tableContainerView
      tableContainerView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor),
      tableContainerView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor),
      tableContainerView.topAnchor.constraint(
        equalTo: tableHeaderContainerView.bottomAnchor),
      tableContainerView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor),
      
      // tableViews
      asksTableView.widthAnchor.constraint(
        equalToConstant: tableViewWidth),
      asksTableView.heightAnchor.constraint(
        equalToConstant: tableViewHeight),
      bidsTableView.widthAnchor.constraint(
        equalToConstant: tableViewWidth),
      bidsTableView.heightAnchor.constraint(
        equalToConstant: tableViewHeight),
      
      // tableViewStack
      tableViewStack.topAnchor.constraint(
        equalTo: tableContainerView.topAnchor),
      tableViewStack.bottomAnchor.constraint(
        greaterThanOrEqualTo: tableContainerView.bottomAnchor,
        constant: 0),
      tableViewStack.centerXAnchor.constraint(
        equalTo: tableContainerView.centerXAnchor)
    ])
    
  }
  
  func setupHeaderView() {
    headerView = HeaderView()
    headerView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setupGraphView() {
    graphContainerView = GraphView(frame: CGRect.zero)
    graphContainerView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setupTableViewHeaders(with size: CGSize) {
    let tableHeaderFrame = getRect(with: size)
    
    asksHeader = PriceTableViewHeader(
      frame: tableHeaderFrame, controller: self)
    bidsHeader = PriceTableViewHeader(
      frame: tableHeaderFrame, controller: self)
  }
  
  func setupTableViews(with size: CGSize) {
    let tableViewFrame = getRect(with: size)
    asksTableView = PricesTableView(frame: tableViewFrame)
    bidsTableView = PricesTableView(frame: tableViewFrame)
    
    [asksTableView, bidsTableView].forEach {
      $0?.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  func getStackView() -> UIStackView {
    let stackView = ViewHelper.createStackView(
      .horizontal, distribution: .fillEqually)
    stackView.spacing = 24
    return stackView
  }
  
  func getEmptyView(color: UIColor) -> UIView {
    let newView = ViewHelper.createEmptyView()
    newView.backgroundColor = color
    return newView
  }
  
  func getRect(with size: CGSize) -> CGRect {
    return CGRect(origin: CGPoint.zero,
                  size: size)
  }
  
  
  // MARK: - Info View
  
  
  
  
  // MARK: - Load View Model
  
  // Get CryptoDetailViewModel
  func loadViewModel() {
    
    // Fetch TableViews Data
    viewModel.fetchTableViewData(with: cryptoSymbol)
    
    viewModel.reloadTableViews = { [weak self] in
      DispatchQueue.main.async {
        let asks = self?.viewModel.asks
        let bids = self?.viewModel.bids
        self?.asksTableView.reloadViewModel(with: asks!, for: .ask)
        self?.bidsTableView.reloadViewModel(with: bids!, for: .bid)

        self?.graphContainerView.loadViewModel(with: asks!)
        
      }
    }
    
    viewModel.noStatsAlert = { [weak self] in
      DispatchQueue.main.async {
        
        self?.navigationController?.navigationBar.topItem?.hidesBackButton = true
        
        let alert = UIAlertController(title: NSLocalizedString("No Stats Available", comment: ""),
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                     style: .default) { action in
          DispatchQueue.main.async {
            self?.navigationController?.popViewController(animated: true)
          }
        }
        alert.addAction(okAction)
        self?.present(alert, animated: true)
        
      }
    }
    
    viewModel.reloadHeader = { [weak self] in
      DispatchQueue.main.async {
        self?.headerView.viewModel = self?.viewModel.headerViewModel
      }
    }
    
  }
  
}


// MARK: - CryptoDetailViewModelDelegate
extension CryptoDetailViewController: CryptoDetailViewModelDelegate {
  
  func reloadTableViewData() {
    loadViewModel()
  }
  
}



