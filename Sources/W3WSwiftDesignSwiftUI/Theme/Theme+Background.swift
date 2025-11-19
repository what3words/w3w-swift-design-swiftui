//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

/// Defines standard system sizes for UI elements such as buttons or backgrounds.
/// - none: No padding or special height.
/// - small: Small horizontal padding and height.
/// - medium: Medium horizontal padding and height.
/// - large: Large horizontal padding and height, with rounded corners.
public enum W3WSize {
  case none
  case small
  case medium
  case large
}

public extension View {
  /// Applies a themed background color using a keyPath, with optional system sizing and corner style.
  /// - Parameters:
  ///   - keyPath: KeyPath to a color property in `W3WTheme`.
  ///   - size: System size style (default is `.none`).
  /// - Returns: A view with the background and shape applied.
  func w3w(background: KeyPath<W3WTheme, W3WColor?>, size: W3WSize = .none) -> some View {
    modifier(W3WBackgroundModifier(keyPath: background, size: size))
  }
}

extension View {
  /// Applies an arbitrary background color (if any), using `.suColor` if available.
  /// - Parameter color: The background color, or nil.
  /// - Returns: The view with the background applied.
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

/// ViewModifier that applies background color, horizontal padding, height, and shape based on theme and size.
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
  /// Horizontal padding for each size.
  var horizontalPadding: CGFloat? {
    switch self {
    case .none: return 0
    case .small: return 10
    case .medium: return 14
    case .large: return 20
    }
  }
  
  /// Height for each size, or nil for `.none` (no constraint).
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
  /// Applies a shape to the view according to the system size style.
  /// - Parameter size: The system size (W3WSize).
  /// - Returns: The view with the appropriate shape (capsule, or rounded rect).
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

// MARK: - Previews

/// Example usage of `w3wBackground` with different size options.
private struct ExampleView: View {
  var body: some View {
    HStack {
      Text("Button")
        .frame(width: 100, height: 40)
        .w3w(background: \.fillsQuaternary)
      Text("Button")
        .w3w(background: \.fillsQuaternary, size: .medium)
    }
    .w3w(foreground: \.labelsSecondary)
    .w3w(font: .subheadline)
  }
}

#Preview {
  ExampleView()
}

