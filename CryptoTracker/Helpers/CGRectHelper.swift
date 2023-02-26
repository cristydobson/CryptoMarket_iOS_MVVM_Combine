//
//  CGRectHelper.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/26/23.
//

import Foundation

extension CGRect {
  
  func getRectFractionSize(w: CGFloat, h: CGFloat) -> CGRect {
    return CGRect(x: 0, y: 0, width: width/w, height: height/h)
  }
  
}
