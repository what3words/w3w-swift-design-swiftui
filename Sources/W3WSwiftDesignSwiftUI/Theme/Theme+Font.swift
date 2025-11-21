//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

public extension W3WSwiftUITheme {
  /// Retrieves a font from the theme according to style, weight, and italic option.
  /// - Parameters:
  ///   - style: Font style (`W3WFontStyle`).
  ///   - weight: Font weight (default is `.regular`).
  ///   - italic: Whether the font should be italic (default is `false`).
  /// - Returns: The themed font, or `nil` if not available.
  func font(_ style: W3WFontStyle, weight: W3WFontWeight = .regular, italic: Bool = false) -> Font? {
    theme.typefaces?[style].with(weight: weight).with(italic: italic).suFont
  }
}

public extension View {
  /// Applies a themed font to the view.
  /// - Parameters:
  ///   - style: Font style (`W3WFontStyle`).
  ///   - weight: Font weight (default is `.regular`).
  ///   - italic: Whether the font should be italic (default is `false`).
  /// - Returns: The view with the font applied.
  func w3w(font: W3WFontStyle, weight: W3WFontWeight = .regular, italic: Bool = false) -> some View {
    modifier(W3WFontModifier(font: font, weight: weight, italic: italic))
  }
}

/// A ViewModifier that applies a themed font to its content.
private struct W3WFontModifier: ViewModifier {
  @Environment(\.theme) private var theme
  let font: W3WFontStyle
  let weight: W3WFontWeight
  let italic: Bool
  
  func body(content: Content) -> some View {
    content.font(theme.font(font, weight: weight, italic: italic))
  }
}

// MARK: - Previews

/// Example of using the theme's font directly via the font method.
private struct ExampleView: View {
  @Environment(\.theme) private var theme
  
  var body: some View {
    Text("Hello w3w!")
      .font(theme.font(.largeTitle, weight: .medium, italic: false))
  }
}

/// Example of using the w3wFont modifier for a view.
private struct ExampleView2: View {
  var body: some View {
    Text("Hello w3w!")
      .w3w(font: .subheadline, weight: .medium, italic: false)
  }
}

#Preview {
  ExampleView()
}

#Preview {
  ExampleView2()
}
