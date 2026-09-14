//
//  W3WToast.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Bottom toast with a message and a close button ("List updated"). Show it conditionally
/// inside an animated container; the slide-up transition is built in.
public struct W3WToast: View {
  private let text: String
  private let background: KeyPath<W3WTheme, W3WColor?>
  private let foreground: KeyPath<W3WTheme, W3WColor?>
  private let closeAccessibilityLabel: String?
  private let onClose: () -> Void

  /// - Parameters:
  ///   - background: the states/* base token; pair it with the matching label token in `foreground`
  ///   - closeAccessibilityLabel: translated VoiceOver label for the icon-only close button
  public init(text: String,
              background: KeyPath<W3WTheme, W3WColor?> = \.successBase,
              foreground: KeyPath<W3WTheme, W3WColor?> = \.successLabel,
              closeAccessibilityLabel: String? = nil,
              onClose: @escaping () -> Void) {
    self.text = text
    self.background = background
    self.foreground = foreground
    self.closeAccessibilityLabel = closeAccessibilityLabel
    self.onClose = onClose
  }

  public var body: some View {
    HStack(spacing: 0) {
      Text(text)
        .w3w(font: .footnote)
        .w3w(foreground: foreground)
        .padding(.leading, 16)
      Spacer(minLength: 8)
      Button(action: onClose) {
        Image(systemName: "xmark")
          .font(.system(size: 24))
          .w3w(foreground: foreground)
          .frame(width: 48, height: 48)
          .contentShape(Rectangle())
      }
      .buttonStyle(.plain)
      .accessibilityLabel(optional: closeAccessibilityLabel)
    }
    .frame(height: 48)
    .w3w(background: background)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .shadow(color: .black, style: W3WShadow(opacity: 0.04, radius: 1, offsetX: 0, offsetY: 3))
    .shadow(color: .black, style: W3WShadow(opacity: 0.12, radius: 8, offsetX: 0, offsetY: 3))
    .padding(.horizontal, 23)
    .transition(.move(edge: .bottom).combined(with: .opacity))
  }
}

#Preview {
  VStack(spacing: 12) {
    W3WToast(text: "List updated") {}
    W3WToast(text: "Something went wrong", background: \.errorElevated, foreground: \.errorLabel) {}
  }
}
