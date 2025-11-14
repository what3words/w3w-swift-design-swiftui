//
//  File.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 14/11/25.
//

import SwiftUI
import W3WSwiftThemes

extension View {
  func w3wButtonStyle(_ keyPath: KeyPath<W3WTheme, W3WColor?>, size: W3WSize) -> some View {
    buttonStyle(W3WButtonStyle(keyPath: keyPath, size: size))
  }
    
  func w3wButtonStyle<S: Shape, Content: View>(
    _ keyPath: KeyPath<W3WTheme, W3WColor?>,
    shape: S,
    modify: @escaping (ButtonStyleConfiguration.Label) -> Content = { $0 }
  ) -> some View {
    buttonStyle(W3WCustomShapeAndSizeButtonStyle(keyPath: keyPath, shape: shape, modify: modify))
  }
  
  func w3wButtonStyle<Content: View>(
    _ keyPath: KeyPath<W3WTheme, W3WColor?>,
    modify: @escaping (ButtonStyleConfiguration.Label) -> Content
  ) -> some View {
    buttonStyle(W3WCustomShapeAndSizeButtonStyle(keyPath: keyPath, shape: .rect, modify: modify))
  }
}

private struct W3WButtonStyle: ButtonStyle {
  @Environment(\.theme) private var theme
  let keyPath: KeyPath<W3WTheme, W3WColor?>
  let size: W3WSize
  
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .w3wBackground(keyPath, size: size)
      .opacity(configuration.isPressed ? 0.25 : 1)
  }
}

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
  .w3wForeground(\.labelsSecondary)
  .w3wFont(.subheadline)
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
  .w3wForeground(\.labelsSecondary)
  .w3wFont(.subheadline)
}
