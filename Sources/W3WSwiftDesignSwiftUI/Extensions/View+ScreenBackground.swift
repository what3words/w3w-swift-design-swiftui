//
//  View+ScreenBackground.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 01/10/2026.
//

import SwiftUI

public extension View {

  /// Fills `color` behind every edge; content stays inside the safe area
  func w3wScreenBackground(_ color: Color) -> some View {
    background(color.ignoresSafeArea())
  }

#if canImport(UIKit)
  func w3wScreenBackground(_ color: UIColor) -> some View {
    w3wScreenBackground(Color(color))
  }
#endif
}
