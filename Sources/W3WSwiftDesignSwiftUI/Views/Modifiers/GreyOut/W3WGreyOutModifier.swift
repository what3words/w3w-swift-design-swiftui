//
//  W3WGreyOutModifier.swift
//  w3w-swift-design-swiftui
//
//  Greys out and disables a view to signal it is inactive — e.g. the buttons in a
//  non-interactive action-panel preview. Centralises the dimmed-opacity treatment so
//  every greyed-out control matches.
//

import SwiftUI

struct W3WGreyOutModifier: ViewModifier {
  /// Opacity applied while greyed out.
  static let greyedOpacity: Double = 0.16

  let isGreyedOut: Bool

  func body(content: Content) -> some View {
    content
      .opacity(isGreyedOut ? Self.greyedOpacity : 1.0)
      .disabled(isGreyedOut)
  }
}

#Preview {
  VStack(spacing: 16) {
    Text("Active").w3wGreyedOut(false)
    Text("Greyed out").w3wGreyedOut(true)
  }
  .padding()
}
