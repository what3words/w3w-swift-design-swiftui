//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

/// Extends the SwiftUI environment values with a theme property for global access.
/// The default is `.what3words` theme.
public extension EnvironmentValues {
  /// The active UI theme, available throughout the SwiftUI environment.
  @Entry var theme = W3WSwiftUITheme(theme: .what3words)
}

/// Extends the environment to track the active color mode (e.g., theme, light, dark).
public extension EnvironmentValues {
  /// The color mode, controls how colors are resolved in the UI.
  @Entry var colorMode: W3WColorMode = W3WColor.theme
}

/// A wrapper that provides dynamic member access for `W3WTheme`,
/// allowing convenient theme property lookups in SwiftUI views.
@dynamicMemberLookup
public struct W3WSwiftUITheme {
  let theme: W3WTheme
}

// MARK: - Modify theme

public extension View {
  /// Modifies the current environment theme for the view and its descendants.
  ///
  /// - Parameter modify: A closure that takes an inout reference to the current theme, allowing mutation.
  /// - Returns: The view with the modified theme applied in its environment.
  func modifyTheme(_ modify: @escaping (inout W3WTheme) -> Void) -> some View {
    modifier(ModifyThemeModifier(modify: modify))
  }
}

/// A view modifier that applies a modified version of the current theme to the environment.
/// This enables view-local theme customization or overrides.
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
