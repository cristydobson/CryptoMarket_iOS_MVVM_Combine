//
//  PricesTableView.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import UIKit

class PricesTableView: UIView {
  
  
  // MARK: - Properties
  var tableView: UITableView!
  var cellID = "TableCell"
  
//  lazy var viewModel = {
//    CryptoCollectionViewModel()
//  }()
  
  
  // MARK: - Init methods
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Startup Methods
  func setupTableView() {
    
    // Instantiate TableView
    tableView = UITableView(frame: frame)
    tableView.backgroundColor = .clear
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // Register the TableView's cell
    tableView.register(PricesTableCell.self, forCellReuseIdentifier: cellID)
    
    // TableView style
    tableView.showsVerticalScrollIndicator = false
    
    // Add TableView to current view
    addSubview(tableView)
    
  }
  
  
}



// MARK: - UITableViewDataSource, UITableViewDelegate
extension PricesTableView: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PricesTableCell
    
    // TODO: - Pass the cellViewModel
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  // TODO: - HEADER with labels
  
}














