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
  
  var asksTableView: PricesTableView!
  var bidsTableView: PricesTableView!
  
  lazy var viewModel = {
    CryptoDetailViewModel()
  }()
  
  let layoutStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  
  // MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Bitcoin"
    view.addGradientBackground()
    
    addViews()
    getViewModel()
  }
  
  
  // MARK: - Add Views
  func addViews() {
   
    let tempView = UIView()
    tempView.backgroundColor = .blue
    view.addSubview(tempView)

    // TableViews Stack
    let tableViewStack = createTableViewsStack()
    let tableViewFrame = view.frame.getRectFractionSize(w: 2, h: 2)
    
    asksTableView = PricesTableView(frame: tableViewFrame)
    bidsTableView = PricesTableView(frame: tableViewFrame)
    view.addSubview(asksTableView)
    view.addSubview(bidsTableView)
    view.addSubview(tableViewStack)

    tableViewStack.addArrangedSubview(asksTableView)
    tableViewStack.addArrangedSubview(bidsTableView)

    // Layout Stack
    view.addSubview(layoutStack)
    layoutStack.addArrangedSubview(tempView)
    layoutStack.addArrangedSubview(tableViewStack)

    layoutStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    layoutStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    layoutStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    layoutStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

  }
  
  func createTableViewsStack() -> UIStackView {
    
    let tableViewStack = UIStackView()
    tableViewStack.axis = .horizontal
    tableViewStack.distribution = .fillEqually
    tableViewStack.backgroundColor = .red
    tableViewStack.translatesAutoresizingMaskIntoConstraints = false
    return tableViewStack
  }
  
  
  
  // Get CryptoDetailViewModel
  func getViewModel() {
    
    viewModel.fetchData(with: cryptoSymbol)
    let asks = viewModel.cryptoMarkets.first?.asks
    let bids = viewModel.cryptoMarkets.first?.bids
    
    viewModel.reloadTableViews = { [weak self] in
      DispatchQueue.main.async {
        self?.asksTableView.reloadViewModel(with: asks!, for: .ask)
        self?.bidsTableView.reloadViewModel(with: bids!, for: .bid)
      }
    }
  }
  
  
  
}
