//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

extension W3WSwiftUITheme {
  /// Allows convenient dynamic member lookup for color values from the theme.
  /// Example: `theme.labelsPrimary` returns the corresponding SwiftUI Color.
  /// - Parameter member: A KeyPath to a `W3WColor?` on `W3WTheme`.
  /// - Returns: The resolved SwiftUI `Color`, or nil.
  subscript(dynamicMember member: KeyPath<W3WTheme, W3WColor?>) -> Color? {
    theme[keyPath: member]?.suColor
  }
}

extension View {
  /// Applies a foreground color to the view, using a keyPath to a color property on the theme.
  /// - Parameter keyPath: KeyPath to a `W3WColor?` property on `W3WTheme`.
  /// - Returns: The view with the appropriate foreground color or style applied.
  func w3wForeground(_ keyPath: KeyPath<W3WTheme, W3WColor?>) -> some View {
    modifier(W3WForegroundColorModifier(keyPath: keyPath))
  }
}

/// ViewModifier that applies a themed foreground color or style to its content.
private struct W3WForegroundColorModifier: ViewModifier {
  @Environment(\.theme) private var theme
  let keyPath: KeyPath<W3WTheme, W3WColor?>
  
  func body(content: Content) -> some View {
    if #available(iOS 15.0, *), let color = theme.theme[keyPath: keyPath]?.suColor {
      content.foregroundStyle(color)
    } else {
      content.foregroundColor(theme.theme[keyPath: keyPath]?.suColor)
    }
  }
}

// MARK: - Previews

/// Example usage of the theme's color directly.
private struct ExampleView: View {
  @Environment(\.theme) private var theme
  
  var body: some View {
    Text("Hello w3w!")
      .foregroundColor(theme.labelsPrimary)
      .background(.black)
  }
}

/// Example usage of the w3wForeground modifier.
private struct ExampleView2: View {
  var body: some View {
    Text("Hello w3w!")
      .w3wForeground(\.labelsPrimary)
      .background(.black)
  }
}

#Preview {
  ExampleView()
}

#Preview {
  ExampleView2()
}
