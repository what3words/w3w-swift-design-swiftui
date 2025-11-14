//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

extension EnvironmentValues {
  @Entry var theme = W3WSwiftUITheme(theme: .what3words)
}

extension EnvironmentValues {
  @Entry var colorMode: W3WColorMode = W3WColor.theme
}

@dynamicMemberLookup
struct W3WSwiftUITheme {
  let theme: W3WTheme
}

// MARK: - Modify theme
extension View {
  func modifyTheme(_ modify: @escaping (inout W3WTheme) -> Void) -> some View {
    modifier(ModifyThemeModifier(modify: modify))
  }
}

private struct ModifyThemeModifier: ViewModifier {
  @Environment(\.theme) private var theme
  
  var modify: (inout W3WTheme) -> Void
  
  func body(content: Content) -> some View {
    content.environment(\.theme, {
      var theme = theme.theme
      modify(&theme)
      return W3WSwiftUITheme(theme: theme)
    }())
  }
}
