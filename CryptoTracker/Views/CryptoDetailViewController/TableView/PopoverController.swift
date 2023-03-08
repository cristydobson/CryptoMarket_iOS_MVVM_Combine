/*
 PopoverController.swift
 
 Presented when PriceTableViewHeader's
 Info button is tapped.
 
 Created by Cristina Dobson
 */


import UIKit


class PopoverController: UIViewController {
  
  
  // MARK: - Properties
  
  var labelText: String!
  var sourceView: UIView!
  
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    
    addViews()
    
    setupPresentationController()
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    view.backgroundColor = .darkestGray
  }
  
  func addViews() {
    
    // Add a single label with information
    let label = getLabel(withText: labelText)
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: 16),
      label.trailingAnchor.constraint(
        equalTo: view.trailingAnchor, constant: -16),
      label.topAnchor.constraint(
        equalTo: view.topAnchor, constant: 4),
      label.bottomAnchor.constraint(
        equalTo: view.bottomAnchor, constant: -18)
    ])
    
  }
  
  
  // MARK: - UI Helper Methods
  
  func getLabel(withText text: String) -> UILabel {
    let label = ViewHelper.createLabel(
      with: .lighterGray, text: text,
      alignment: .center,
      font: UIFont.systemFont(ofSize: 16, weight: .regular))
    label.numberOfLines = .max
    return label
  }
  
  
  // MARK: - Setup The PresentationController
  
  func setupPresentationController() {
    let presentationController = popoverPresentationController!
    presentationController.sourceView = sourceView
    presentationController.sourceRect = sourceView.bounds
    presentationController.backgroundColor = .darkestGray
    presentationController.permittedArrowDirections = .down
  }
  
}


