//
//  W3WDetents.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 16/8/25.
//

import Foundation

public struct W3WDetents {
  
  private let detents: [CGFloat]

  public init(detents: [CGFloat]) {
    self.detents = detents
  }
  
  public func nearest(value: CGFloat) -> CGFloat {
    detents.min { abs($0 - value) < abs($1 - value) } ?? 0
  }
}
