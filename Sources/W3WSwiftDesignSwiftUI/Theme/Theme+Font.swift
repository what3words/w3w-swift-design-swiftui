//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

extension W3WSwiftUITheme {
  func font(_ style: W3WFontStyle, weight: W3WFontWeight = .regular, italic: Bool = false) -> Font? {
    theme.typefaces?[style].with(weight: weight).with(italic: italic).suFont
  }
}

extension View {
  func w3wFont(_ style: W3WFontStyle, weight: W3WFontWeight = .regular, italic: Bool = false) -> some View {
    modifier(W3WFontModifier(style: style, weight: weight, italic: italic))
  }
}

private struct W3WFontModifier: ViewModifier {
  @Environment(\.theme) private var theme
  let style: W3WFontStyle
  let weight: W3WFontWeight
  let italic: Bool
  
  func body(content: Content) -> some View {
    content.font(theme.font(style, weight: weight, italic: italic))
  }
}

// MARK: - Previews
private struct ExampleView: View {
  @Environment(\.theme) private var theme
  
  var body: some View {
    Text("Hello w3w!")
      .font(theme.font(.largeTitle, weight: .medium, italic: false))
  }
}

private struct ExampleView2: View {
  var body: some View {
    Text("Hello w3w!")
      .w3wFont(.subheadline, weight: .medium, italic: false)
  }
}

#Preview {
  ExampleView()
}

#Preview {
  ExampleView2()
}
