//
//  AnyShape.swift
//  w3w-swift-design-swiftui
//
//  Created by Khai Do on 15/4/25.
//

import SwiftUI

struct AnyShape: Shape, Sendable {
  private let shapePath: @Sendable (CGRect) -> Path

  init<S: Shape & Sendable>(_ shape: S) {
    self.shapePath = { rect in
      shape.path(in: rect)
    }
  }

  func path(in rect: CGRect) -> Path {
    shapePath(rect)
  }
}
