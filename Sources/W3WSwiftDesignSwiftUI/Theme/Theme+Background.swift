//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

enum W3WSize {
  case none
  case small
  case medium
  case large
}

extension View {
  func w3wBackground(_ keyPath: KeyPath<W3WTheme, W3WColor?>, size: W3WSize = .none) -> some View {
    modifier(W3WBackgroundModifier(keyPath: keyPath, size: size))
  }
  
  @ViewBuilder
  func background(_ color: W3WColor?) -> some View {
    if #available(iOS 15.0, *), let color = color?.suColor {
      background { color }
    } else {
      background(color?.suColor)
    }
  }
}

// MARK: - Helpers
private struct W3WBackgroundModifier: ViewModifier {
  @Environment(\.theme) private var theme
  let keyPath: KeyPath<W3WTheme, W3WColor?>
  let size: W3WSize
  
  func body(content: Content) -> some View {
    content
      .padding(.horizontal, size.horizontalPadding)
      .frame(height: size.height)
      .background(theme.theme[keyPath: keyPath])
      .clipShape(size)
  }
}

private extension W3WSize {
  var horizontalPadding: CGFloat? {
    switch self {
    case .none: return 0
    case .small: return 10
    case .medium: return 14
    case .large: return 20
    }
  }
  
  var height: CGFloat? {
    switch self {
    case .none: return nil
    case .small: return 28
    case .medium: return 34
    case .large: return 50
    }
  }
}

private extension View {
  @ViewBuilder
  func clipShape(_ size: W3WSize) -> some View {
    switch size {
    case .none: self
    case .small: clipShape(.capsule)
    case .medium: clipShape(.capsule)
    case .large: clipShape(.rect(cornerRadius: 12))
    }
  }
}

// MARK: - Example
private struct ExampleView: View {
  var body: some View {
    HStack {
      Text("Button")
        .frame(width: 100, height: 40)
        .w3wBackground(\.fillsQuaternary)
      Text("Button")
        .w3wBackground(\.fillsQuaternary, size: .medium)
    }
    .w3wForeground(\.labelsSecondary)
    .w3wFont(.subheadline)
  }
}

#Preview {
  ExampleView()
}
