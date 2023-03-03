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
  
  var asksTableView: PricesTableView!
  var bidsTableView: PricesTableView!
  
  let tableViewHeaderStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 24
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let tableViewStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 24
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  
  // MARK: - View Model Property
  
  lazy var viewModel = {
    CryptoDetailViewModel()
  }()
  
  
  // MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.topItem?.backButtonTitle = NSLocalizedString("Back", comment: "")
    
    view.backgroundColor = .black
 
    addViews()
    
    viewModel.delegate = self
    viewModel.cryptoSymbol = cryptoSymbol
    loadViewModel()
  }
  
  
  // MARK: - Add Views
  
  func addViews() {

    let safeArea = view.safeAreaLayoutGuide
    let horizontalPadding: CGFloat = 48
    
    let viewWidth = view.frame.width
    let viewHeight = view.frame.height
    let viewHeightFraction = viewHeight/12
    
    
    /*
     Header View
     */
    setupHeaderView()
    view.addSubview(headerView)
    
    let headerViewHeight = viewHeightFraction
  
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
      headerView.setHeightContraint(by: headerViewHeight)
    ])
    
    
    /*
     Graph Container View
     */
    setupGraphView()
    let graphViewHeight = viewHeightFraction * 5
    view.addSubview(graphContainerView)
    
    NSLayoutConstraint.activate([
      graphContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      graphContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      graphContainerView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 8),
      graphContainerView.setHeightContraint(by: graphViewHeight)
    ])
    
    
    /*
     Table View Sizes
     */
    let tableViewWidth = (viewWidth - horizontalPadding) / 2
    let tableViewHeight = viewHeightFraction * 4.5


    /*
     TableView Header Stack
     */
    let tableHeaderHeight: CGFloat = 34
    
    let tableHeaderContainerView = UIView()
    tableHeaderContainerView.translatesAutoresizingMaskIntoConstraints = false
    tableHeaderContainerView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    
    let tableHeaderFrame = CGRect(origin: CGPoint.zero,
                                  size: CGSize(width: tableViewWidth, height: tableHeaderHeight))
    let asksHeader = PriceTableViewHeader(frame: tableHeaderFrame)
    let bidsHeader = PriceTableViewHeader(frame: tableHeaderFrame)

    tableHeaderContainerView.addSubview(asksHeader)
    tableHeaderContainerView.addSubview(bidsHeader)
    tableHeaderContainerView.addSubview(tableViewHeaderStack)
    view.addSubview(tableHeaderContainerView)

    tableViewHeaderStack.addArrangedSubview(asksHeader)
    tableViewHeaderStack.addArrangedSubview(bidsHeader)
    
    NSLayoutConstraint.activate([
      // tableHeaderContainerView
      tableHeaderContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      tableHeaderContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      tableHeaderContainerView.topAnchor.constraint(equalTo: graphContainerView.bottomAnchor, constant: 24),
      tableHeaderContainerView.setHeightContraint(by: tableHeaderHeight),
      
      asksHeader.setWidthContraint(by: tableViewWidth),
      asksHeader.setHeightContraint(by: tableHeaderHeight),
      bidsHeader.setWidthContraint(by: tableViewWidth),
      bidsHeader.setHeightContraint(by: tableHeaderHeight),
      
      // tableViewHeaderStack
      tableViewHeaderStack.topAnchor.constraint(equalTo: tableHeaderContainerView.topAnchor),
      tableViewHeaderStack.bottomAnchor.constraint(equalTo: tableHeaderContainerView.bottomAnchor),
      tableViewHeaderStack.centerXAnchor.constraint(equalTo: tableHeaderContainerView.centerXAnchor),
    ])


    /*
     Price TableViews
     */
    // Container View
    let tableContainerView = UIView()
    
    // Table Views
    let tableViewFrame = CGRect(origin: CGPoint.zero,
                                size: CGSize(width: tableViewWidth, height: tableViewHeight))
    asksTableView = PricesTableView(frame: tableViewFrame)
    bidsTableView = PricesTableView(frame: tableViewFrame)
    
    [tableContainerView, asksTableView, bidsTableView].forEach {
      $0?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    tableContainerView.addSubview(asksTableView)
    tableContainerView.addSubview(bidsTableView)
    tableContainerView.addSubview(tableViewStack)
    view.addSubview(tableContainerView)
    
    // Table View Container Stack
    tableViewStack.addArrangedSubview(asksTableView)
    tableViewStack.addArrangedSubview(bidsTableView)
    
    let tableViewStackBottomConstraint = tableViewStack.bottomAnchor.constraint(
      equalTo: tableContainerView.bottomAnchor)
    tableViewStackBottomConstraint.priority = UILayoutPriority(750)
    
    NSLayoutConstraint.activate([
      // tableContainerView
      tableContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      tableContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      tableContainerView.topAnchor.constraint(equalTo: tableHeaderContainerView.bottomAnchor),
      tableContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      // tableViews
      asksTableView.widthAnchor.constraint(equalToConstant: tableViewWidth),
      asksTableView.heightAnchor.constraint(equalToConstant: tableViewHeight),
      bidsTableView.widthAnchor.constraint(equalToConstant: tableViewWidth),
      bidsTableView.heightAnchor.constraint(equalToConstant: tableViewHeight),
      
      // tableViewStack
      tableViewStack.topAnchor.constraint(equalTo: tableContainerView.topAnchor),
      tableViewStack.bottomAnchor.constraint(greaterThanOrEqualTo: tableContainerView.bottomAnchor, constant: 0),
      tableViewStackBottomConstraint,
      tableViewStack.centerXAnchor.constraint(equalTo: tableContainerView.centerXAnchor)
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
  
  
  // MARK: - Load View Model
  
  // Get CryptoDetailViewModel
  func loadViewModel() {
    
    viewModel.fetchData(with: cryptoSymbol)
    
    viewModel.reloadTableViews = { [weak self] in
      DispatchQueue.main.async {
        let asks = self?.viewModel.asks
        let bids = self?.viewModel.bids
        self?.asksTableView.reloadViewModel(with: asks!, for: .ask)
        self?.bidsTableView.reloadViewModel(with: bids!, for: .bid)

        self?.headerView.viewModel = self?.viewModel.headerViewModel

        self?.graphContainerView.loadViewModel(with: asks!)
      }
    }
    
    viewModel.noStatsAlert = { [weak self] in
      DispatchQueue.main.async {
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
  }
 
}


// MARK: - CryptoDetailViewModelDelegate
extension CryptoDetailViewController: CryptoDetailViewModelDelegate {
  
  func reloadTableViewData() {
    loadViewModel()
  }
  
}



