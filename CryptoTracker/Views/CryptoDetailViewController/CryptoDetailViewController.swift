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
    
    viewModel.delegate = self
    reloadViewModelData()
  }
//
  
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
    tableViewStack.translatesAutoresizingMaskIntoConstraints = false
    return tableViewStack
  }
  
  
  // Get CryptoDetailViewModel
  func reloadViewModelData() {
    
    viewModel.fetchData(with: cryptoSymbol)
    
    viewModel.reloadTableViews = { [weak self] in
      DispatchQueue.main.async {
        let asks = self?.viewModel.asks
        let bids = self?.viewModel.bids
        self?.asksTableView.reloadViewModel(with: asks!, for: .ask)
        self?.bidsTableView.reloadViewModel(with: bids!, for: .bid)
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
    reloadViewModelData()
  }
  
}
