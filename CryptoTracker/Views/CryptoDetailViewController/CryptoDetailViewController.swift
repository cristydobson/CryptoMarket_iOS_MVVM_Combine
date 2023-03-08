/*
 CryptoDetailViewController.swift
 
 Display the data from a single Crypto Currency.
 
 Created by Cristina Dobson
 */


import UIKit


class CryptoDetailViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var cryptoSymbol = ""
  
  var headerView: HeaderView!
  
  var graphContainerView: GraphView!
  
  
  // MARK: - TableViews Properties
  
  var asksHeader: PriceTableViewHeader!
  var bidsHeader: PriceTableViewHeader!
  var asksTableView: PricesTableView!
  var bidsTableView: PricesTableView!
  
  
  // MARK: - View Model
  
  lazy var viewModel = {
    CryptoDetailViewModel()
  }()
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    addViews()
    
    viewModel.delegate = self
    loadViewModel()
    
    setPopoverCalls()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Stop the timer to refresh data on the ViewModel.
    viewModel.cancelTimer()
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    navigationController?.navigationBar.topItem?
      .backButtonTitle = NSLocalizedString("Back", comment: "")
    
    view.backgroundColor = .black
  }
  
  func addViews() {

    // View Sizes
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
     1.- Header View
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
     2.- Graph Container View
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
     3.- TableView Headers
     */
    
    let tableHeaderContainerView = getEmptyView(color: .darkestGray)
    
    setupTableViewHeaders(
      with: CGSize(width: tableViewWidth,
                   height: tableHeaderHeight))
    
    let tableViewHeaderStack = getStackView()
    
    // Add views to the container view
    tableHeaderContainerView.addSubview(asksHeader)
    tableHeaderContainerView.addSubview(bidsHeader)
    tableHeaderContainerView.addSubview(tableViewHeaderStack)
    view.addSubview(tableHeaderContainerView)

    // Arrange the TableView Headers in their container stack
    tableViewHeaderStack.addArrangedSubview(asksHeader)
    tableViewHeaderStack.addArrangedSubview(bidsHeader)
    
    NSLayoutConstraint.activate([
      // TableHeaderContainerView
      tableHeaderContainerView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor),
      tableHeaderContainerView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor),
      tableHeaderContainerView.topAnchor.constraint(
        equalTo: graphContainerView.bottomAnchor, constant: 24),
      tableHeaderContainerView.setHeightContraint(
        by: tableHeaderHeight),
      
      // TableView Headers
      asksHeader.setWidthContraint(by: tableViewWidth),
      asksHeader.setHeightContraint(by: tableHeaderHeight),
      bidsHeader.setWidthContraint(by: tableViewWidth),
      bidsHeader.setHeightContraint(by: tableHeaderHeight),
      
      // TableView Headers Stack
      tableViewHeaderStack.topAnchor.constraint(
        equalTo: tableHeaderContainerView.topAnchor),
      tableViewHeaderStack.bottomAnchor.constraint(
        equalTo: tableHeaderContainerView.bottomAnchor),
      tableViewHeaderStack.centerXAnchor.constraint(
        equalTo: tableHeaderContainerView.centerXAnchor),
    ])


    /*
     4.- TableViews
     */
    
    // Container View
    let tableContainerView = getEmptyView(color: .clear)
    
    // Create the TableViews
    setupTableViews(with: CGSize(width: tableViewWidth,
                                 height: tableViewHeight))
    
    let tableViewStack = getStackView()
    
    // Add the TableViews to their container view.
    tableContainerView.addSubview(asksTableView)
    tableContainerView.addSubview(bidsTableView)
    tableContainerView.addSubview(tableViewStack)
    view.addSubview(tableContainerView)
    
    // Arrange the TableViews in their container stack.
    tableViewStack.addArrangedSubview(asksTableView)
    tableViewStack.addArrangedSubview(bidsTableView)
    
    NSLayoutConstraint.activate([
      // TableContainerView
      tableContainerView.leadingAnchor.constraint(
        equalTo: safeArea.leadingAnchor),
      tableContainerView.trailingAnchor.constraint(
        equalTo: safeArea.trailingAnchor),
      tableContainerView.topAnchor.constraint(
        equalTo: tableHeaderContainerView.bottomAnchor),
      tableContainerView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor),
      
      // TableViews
      asksTableView.widthAnchor.constraint(
        equalToConstant: tableViewWidth),
      asksTableView.heightAnchor.constraint(
        equalToConstant: tableViewHeight),
      bidsTableView.widthAnchor.constraint(
        equalToConstant: tableViewWidth),
      bidsTableView.heightAnchor.constraint(
        equalToConstant: tableViewHeight),
      
      // TableViewStack
      tableViewStack.topAnchor.constraint(
        equalTo: tableContainerView.topAnchor),
      tableViewStack.bottomAnchor.constraint(
        greaterThanOrEqualTo: tableContainerView.bottomAnchor,
        constant: 0),
      tableViewStack.centerXAnchor.constraint(
        equalTo: tableContainerView.centerXAnchor)
    ])
    
  }
  
  
  // MARK: - UI Helper Methods
  
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
    
    asksHeader = PriceTableViewHeader(frame: tableHeaderFrame)
    bidsHeader = PriceTableViewHeader(frame: tableHeaderFrame)
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
  
}


// MARK: - Load View Model

extension CryptoDetailViewController {
  
  func loadViewModel() {
    
    // Fetch the TableViews Data
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
    
    /*
     The data returned is missing the ASK and BID arrays.
     Alert the user before popping the ViewController.
     */
    viewModel.noStatsAlert = { [weak self] in
      DispatchQueue.main.async {
        
        self?.navigationController?.navigationBar.topItem?.hidesBackButton = true
        
        let alert = UIAlertController(
          title: NSLocalizedString("No Stats Available", comment: ""),
          message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(
          title: NSLocalizedString("OK", comment: ""), style: .default) { action in
            
          DispatchQueue.main.async {
            self?.navigationController?.popViewController(animated: true)
          }
        }
        alert.addAction(okAction)
        self?.present(alert, animated: true)
        
      }
    }
    
    // Load the HeaderView after the data was successfully returned.
    viewModel.reloadHeader = { [weak self] in
      DispatchQueue.main.async {
        self?.headerView.viewModel = self?.viewModel.headerViewModel
      }
    }
  }
  
}


// MARK: - CryptoDetailViewModelDelegate

extension CryptoDetailViewController: CryptoDetailViewModelDelegate {
  
  // The timer has triggered a refresh of the data.
  func reloadTableViewData() {
    loadViewModel()
  }
  
}


// MARK: - Info Popover

extension CryptoDetailViewController: UIPopoverPresentationControllerDelegate {
  
  // Setup the callbacks from the info button popover views.
  func setPopoverCalls() {
    asksHeader.infoButtonPressed = { [weak self] in
      DispatchQueue.main.async {
        self?.createPopover(
          from: .ask,
          withText: NSLocalizedString("ASK PRICE: lowest price from the sellers", comment: ""))
      }
    }
    
    bidsHeader.infoButtonPressed = { [weak self] in
      DispatchQueue.main.async {
        self?.createPopover(
          from: .bid,
          withText: NSLocalizedString("BID PRICE: highest price from the buyers", comment: ""))
      }
    }
  }
  
  /*
   Create a popover view when the info button on
   the TableViewHeaders is tapped on.
   */
  func createPopover(from sourceType: PriceType, withText text: String) {
    
    let popoverVc = PopoverController()
    popoverVc.modalPresentationStyle = .popover
    popoverVc.popoverPresentationController?.delegate = self
    popoverVc.preferredContentSize = CGSize(width: 200, height: 80)
    popoverVc.labelText = text
    
    let sourceView: PriceTableViewHeader = sourceType == .ask ?
    asksHeader : bidsHeader
    popoverVc.sourceView = sourceView
    
    present(popoverVc, animated: true)
  }
  
  // UIPopoverPresentationControllerDelegate
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
  
}
