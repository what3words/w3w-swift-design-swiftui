//
//  W3WWritingDirection+LayoutDirection.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 27/10/26.
//

import SwiftUI
import W3WSwiftCore

public extension W3WWritingDirection {
  /// SwiftUI layout direction; vertical scripts lay out left to right.
  func toLayoutDirection() -> LayoutDirection {
    switch self {
    case .leftToRight:
      return .leftToRight
    case .rightToLeft:
      return .rightToLeft
    case .topToBottom, .bottomToTop:
      return .leftToRight
    }
  }
}
