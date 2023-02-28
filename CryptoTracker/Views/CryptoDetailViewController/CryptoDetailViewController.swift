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
  
  let headerStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
//    stackView.spacing = 24
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  lazy var viewModel = {
    CryptoDetailViewModel()
  }()
  
  
  // MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = cryptoSymbol.getCryptoNameString()
    navigationController?.navigationBar.topItem?.backButtonTitle = NSLocalizedString("Back", comment: "")
    
    view.addGradientBackground()
    
    addViews()
    
    viewModel.delegate = self
    loadViewModel()
  }
  
  // MARK: - Add Views
  func addViews() {
   
    let tempView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height/2)*1.25))
    tempView.backgroundColor = .blue
    view.addSubview(tempView)
    tempView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tempView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tempView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    
    
    // TableView Header Stack
    let headerHeight: CGFloat = 80
    let headerFrame = CGRect(origin: .zero,
                              size: CGSize(width: view.frame.width/2, height: headerHeight))
    let asksHeader = PriceTableViewHeader(frame: headerFrame, for: .ask)
    let bidsHeader = PriceTableViewHeader(frame: headerFrame, for: .bid)
    
    view.addSubview(asksHeader)
    view.addSubview(bidsHeader)
    
    let headerYOrigin = (view.frame.height/2)*1.25
    headerStack.frame.origin.y = headerYOrigin
    view.addSubview(headerStack)
    
    headerStack.addArrangedSubview(asksHeader)
    headerStack.addArrangedSubview(bidsHeader)
    
    headerStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    headerStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    headerStack.topAnchor.constraint(equalTo: tempView.bottomAnchor).isActive = true
    

    // Price TableViews
    let stackHeight = ((view.frame.height/2)*0.75) - headerHeight
    let tableViewStack = createTableViewsStack(from: headerYOrigin + headerHeight,
                                               and: stackHeight)
    let tableViewFrame = CGRect(x: 0, y: 0,
                                width: view.frame.width/2,
                                height: 500)
    asksTableView = PricesTableView(frame: tableViewFrame)
    bidsTableView = PricesTableView(frame: tableViewFrame)
    view.addSubview(asksTableView)
    view.addSubview(bidsTableView)
    view.addSubview(tableViewStack)
    
    tableViewStack.addArrangedSubview(asksTableView)
    tableViewStack.addArrangedSubview(bidsTableView)
    

    tableViewStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableViewStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableViewStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor).isActive = true
    tableViewStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
  }
  
  func createTableViewsStack(from yOrigin: CGFloat, and height: CGFloat) -> UIStackView {
    let stackFrame = CGRect(origin: CGPoint(x: 0, y: yOrigin),
                           size: CGSize(width: view.frame.width, height: height))
//    let tableViewStack = UIStackView(frame: stackFrame)
    let tableViewStack = UIStackView()
    tableViewStack.frame.origin.y = yOrigin
    tableViewStack.axis = .horizontal
    tableViewStack.distribution = .fillEqually
//    tableViewStack.spacing = 4
    tableViewStack.backgroundColor = .red
    tableViewStack.translatesAutoresizingMaskIntoConstraints = false
    return tableViewStack
  }
  
  
  // Get CryptoDetailViewModel
  func loadViewModel() {
    
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
    loadViewModel()
  }
  
}
