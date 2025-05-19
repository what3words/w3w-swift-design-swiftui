//
//  Image+Extensions.swift
//  w3w-swift-design-swiftui
//
//  Created by Khai Do on 15/5/25.
//

import SwiftUI

public extension Image {
  @ViewBuilder
  func imageColor(_ color: Color? = nil) -> some View {
    if let color {
      self
        .renderingMode(.template)
        .foregroundColor(color)
    } else {
      self
    }
  }
}
