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
  
  let headerStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  let tableViewStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.backgroundColor = .black
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
    
    let viewWidth = view.frame.width
    let viewHeight = view.frame.height
    let viewHeightFraction = viewHeight/12
    
    
    // Header View
    setupHeaderView()
    view.addSubview(headerView)
    
    let headerViewHeight = viewHeightFraction
    let toTopAnchor: CGFloat = 24
    
    let headerContainerConstraints = [
      headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: toTopAnchor),
      headerView.setHeightContraint(by: headerViewHeight)
    ]
    NSLayoutConstraint.activate(headerContainerConstraints)
    
    
    // Graph Container View
    setupGraphView()
    let graphViewHeight = viewHeightFraction * 5
    view.addSubview(graphContainerView)

    let graphViewConstraints = [
      graphContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      graphContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      graphContainerView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      graphContainerView.setHeightContraint(by: graphViewHeight)
    ]
    NSLayoutConstraint.activate(graphViewConstraints)


    // TableView Header Stack
    let asksHeader = PriceTableViewHeader(frame: CGRect.zero, for: .ask)
    let bidsHeader = PriceTableViewHeader(frame: CGRect.zero, for: .bid)

    view.addSubview(asksHeader)
    view.addSubview(bidsHeader)
    view.addSubview(headerStack)

    headerStack.addArrangedSubview(asksHeader)
    headerStack.addArrangedSubview(bidsHeader)

    let tableViewHeaderConstraints = [
      headerStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      headerStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      headerStack.topAnchor.constraint(equalTo: graphContainerView.bottomAnchor, constant: 24)
    ]
    NSLayoutConstraint.activate(tableViewHeaderConstraints)


    // Price TableViews
    let tableViewStackHeight = viewHeightFraction * 4.5
    let tableViewFrame = CGRect(x: 0, y: 0,
                                width: viewWidth/2,
                                height: tableViewStackHeight)
    asksTableView = PricesTableView(frame: tableViewFrame)
    bidsTableView = PricesTableView(frame: tableViewFrame)
    view.addSubview(asksTableView)
    view.addSubview(bidsTableView)
    view.addSubview(tableViewStack)

    tableViewStack.addArrangedSubview(asksTableView)
    tableViewStack.addArrangedSubview(bidsTableView)

    let tableViewStackConstraints = [
      tableViewStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
      tableViewStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 24),
      tableViewStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor),
      tableViewStack.setHeightContraint(by: tableViewStackHeight)
    ]
    NSLayoutConstraint.activate(tableViewStackConstraints)

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



