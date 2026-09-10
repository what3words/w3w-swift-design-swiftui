//
//  W3WHeaderIconButton.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// 24pt glyph button for the action slots of `W3WScreenHeaderBar`. Icon-only, so pass a
/// translated `accessibilityLabel` for VoiceOver.
public struct W3WHeaderIconButton: View {
  private enum Glyph {
    case system(String)
    case w3w(W3WImage)
  }

  private let glyph: Glyph
  private let accessibilityLabel: String?
  private let action: () -> Void

  public init(systemName: String, accessibilityLabel: String? = nil, action: @escaping () -> Void) {
    self.glyph = .system(systemName)
    self.accessibilityLabel = accessibilityLabel
    self.action = action
  }

  public init(iconImage: W3WImage, accessibilityLabel: String? = nil, action: @escaping () -> Void) {
    self.glyph = .w3w(iconImage)
    self.accessibilityLabel = accessibilityLabel
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      glyphView
        .w3w(foreground: \.labelsSecondary)
        .frame(width: 24, height: 24)
        // 24pt visual like the HIG bar button; a 32pt target fills the 8pt gaps without overlapping a neighbour
        .contentShape(Rectangle().inset(by: -4))
    }
    .buttonStyle(.plain)
    .accessibilityLabel(optional: accessibilityLabel)
  }

  @ViewBuilder
  private var glyphView: some View {
    switch glyph {
    case .system(let name):
      Image(systemName: name)
        .font(.system(size: 17))
    case .w3w(let image):
      Image(uiImage: image.get())
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .squareFrame(17)
    }
  }
}

#Preview {
  HStack {
    W3WHeaderIconButton(systemName: "chevron.left", accessibilityLabel: "Back") {}
    W3WHeaderIconButton(systemName: "ellipsis", accessibilityLabel: "More") {}
    W3WHeaderIconButton(iconImage: .chevronLeft) {}
  }
  .padding()
}
