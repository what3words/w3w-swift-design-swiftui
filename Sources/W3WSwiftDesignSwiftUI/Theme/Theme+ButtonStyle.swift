//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

public extension View {
  /// Applies a standardized button style based on the theme color and system size.
  /// - Parameters:
  ///   - keyPath: KeyPath to a color property in `W3WTheme` to use as the button background.
  ///   - size: The system size (for background, height, and padding).
  /// - Returns: A view with the button style applied.
  func w3wButtonStyle(_ keyPath: KeyPath<W3WTheme, W3WColor?>, size: W3WSize) -> some View {
    buttonStyle(W3WButtonStyle(keyPath: keyPath, size: size))
  }
  
  /// Applies a button style with a custom shape and supports further customization of the button label view.
  /// - Parameters:
  ///   - keyPath: KeyPath to a color property in `W3WTheme` for the background.
  ///   - shape: The custom shape to use for the button background.
  ///   - modify: Closure allowing customization of the button label view
  /// - Returns: A view with the custom button style applied.
  func w3wButtonStyle<S: Shape, Content: View>(
    _ keyPath: KeyPath<W3WTheme, W3WColor?>,
    shape: S,
    modify: @escaping (ButtonStyleConfiguration.Label) -> Content = { $0 }
  ) -> some View {
    buttonStyle(W3WCustomShapeAndSizeButtonStyle(keyPath: keyPath, shape: shape, modify: modify))
  }

  /// Applies a button style with a default rectangular shape (no corner radius) and allows label view customization.
  /// - Parameters:
  ///   - keyPath: KeyPath to a color property in `W3WTheme` for the background.
  ///   - modify: Closure allowing customization of the button label view.
  /// - Returns: A view with the custom button style applied.
  func w3wButtonStyle<Content: View>(
    _ keyPath: KeyPath<W3WTheme, W3WColor?>,
    modify: @escaping (ButtonStyleConfiguration.Label) -> Content
  ) -> some View {
    buttonStyle(W3WCustomShapeAndSizeButtonStyle(keyPath: keyPath, shape: .rect, modify: modify))
  }
}

/// ButtonStyle that applies a themed background, padding, and shape based on the system size.
private struct W3WButtonStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  let keyPath: KeyPath<W3WTheme, W3WColor?>
  let size: W3WSize
  
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .w3w(background: keyPath, size: size)
      .opacity(configuration.isPressed ? 0.25 : 1)
  }
}

/// ButtonStyle that applies a themed background and a custom shape.
private struct W3WCustomShapeButtonStyle<S: Shape>: ButtonStyle {
  @Environment(\.theme) private var theme
  let keyPath: KeyPath<W3WTheme, W3WColor?>
  let shape: S
  
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .background(theme.theme[keyPath: keyPath])
      .clipShape(shape)
      .opacity(configuration.isPressed ? 0.25 : 1)
  }
}

/// ButtonStyle that applies a themed background, a custom shape, and custom label content.
/// The button label can be further modified (for padding, etc.) via the `modify` closure.
private struct W3WCustomShapeAndSizeButtonStyle<S: Shape, Content: View>: ButtonStyle {
  @Environment(\.theme) private var theme
  let keyPath: KeyPath<W3WTheme, W3WColor?>
  let shape: S
  let modify: (ButtonStyleConfiguration.Label) -> Content
  
  func makeBody(configuration: Configuration) -> some View {
    modify(configuration.label)
      .background(theme.theme[keyPath: keyPath])
      .clipShape(shape)
      .opacity(configuration.isPressed ? 0.25 : 1)
  }
}

// MARK: - Previews

@available(iOS 14.0, *)
#Preview {
  HStack {
    Button("Share", systemImage: "square.and.arrow.up", action: {})
    Button("Share", action: {})
  }
  .w3wButtonStyle(\.fillsQuaternary, size: .medium)
  .w3w(foreground: \.labelsSecondary)
  .w3w(font: .subheadline)
}

@available(iOS 14.0, *)
#Preview {
  HStack {
    Button("Share", systemImage: "square.and.arrow.up", action: {})
    Button("Share", action: {})
  }
  .w3wButtonStyle(\.fillsQuaternary, shape: .rect(cornerRadius: 5)) { label in
    label.padding(8)
  }
  .w3w(foreground: \.labelsSecondary)
  .w3w(font: .subheadline)
}
