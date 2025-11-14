//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

extension W3WSwiftUITheme {
  subscript(dynamicMember member: KeyPath<W3WTheme, W3WColor?>) -> Color? {
    theme[keyPath: member]?.suColor
  }
}

extension View {
  func w3wForeground(_ keyPath: KeyPath<W3WTheme, W3WColor?>) -> some View {
    modifier(W3WForegroundColorModifier(keyPath: keyPath))
  }
}

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
private struct ExampleView: View {
  @Environment(\.theme) private var theme
  
  var body: some View {
    Text("Hello w3w!")
      .foregroundColor(theme.labelsPrimary)
      .background(.black)
  }
}

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
