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
  
  
  // MARK: - Graph Properties
  
  var graphContainerView: GraphView!
  
  
  // MARK: - View Model Property
  
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

    let safeArea = view.safeAreaLayoutGuide
    
    let viewWidth = view.frame.width
    let viewHeight = view.frame.height
    let viewHeightFraction = viewHeight/12
    
    // Price / Latest Price / Change % - Stack
    let topStackHeight = viewHeightFraction
    
    let view1 = UIView()
    view.addSubview(view1)
    
    let view2 = UIView()
    view.addSubview(view2)
    
    let view3 = UIView()
    view.addSubview(view3)
    
    let priceChangeStack = UIStackView()
    priceChangeStack.axis = .horizontal
    priceChangeStack.distribution = .fillEqually
    priceChangeStack.backgroundColor = .red
    priceChangeStack.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(priceChangeStack)
    
    priceChangeStack.addArrangedSubview(view1)
    priceChangeStack.addArrangedSubview(view2)
    priceChangeStack.addArrangedSubview(view3)
    
    let priceChangeStackConstraints = [
      priceChangeStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      priceChangeStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      priceChangeStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
      priceChangeStack.setHeightContraint(by: topStackHeight)
    ]
    NSLayoutConstraint.activate(priceChangeStackConstraints)
    
    
    // Graph Container View
    setupGraphView()
    let graphViewHeight = viewHeightFraction * 5
    view.addSubview(graphContainerView)

    let graphViewConstraints = [
      graphContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      graphContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      graphContainerView.topAnchor.constraint(equalTo: priceChangeStack.bottomAnchor),
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
      headerStack.topAnchor.constraint(equalTo: graphContainerView.bottomAnchor)
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
      tableViewStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      tableViewStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      tableViewStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor),
      tableViewStack.setHeightContraint(by: tableViewStackHeight)
    ]
    NSLayoutConstraint.activate(tableViewStackConstraints)

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



