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
  private let closeAccessibilityLabel: String?
  private let onClose: () -> Void

  /// - Parameter closeAccessibilityLabel: translated VoiceOver label for the icon-only close button
  public init(text: String,
              background: KeyPath<W3WTheme, W3WColor?> = \.successBase,
              closeAccessibilityLabel: String? = nil,
              onClose: @escaping () -> Void) {
    self.text = text
    self.background = background
    self.closeAccessibilityLabel = closeAccessibilityLabel
    self.onClose = onClose
  }

  public var body: some View {
    HStack {
      Text(text)
        .w3w(font: .subheadline)
        .w3w(foreground: \.labelsPrimary)
      Spacer()
      Button(action: onClose) {
        Image(systemName: "xmark")
          .font(.system(size: 12, weight: .semibold))
          .w3w(foreground: \.labelsPrimary)
      }
      .buttonStyle(.plain)
      .accessibilityLabel(optional: closeAccessibilityLabel)
    }
    .padding(.horizontal, 16)
    .frame(height: 48)
    .w3w(background: background)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .padding(.horizontal, 22)
    .transition(.move(edge: .bottom).combined(with: .opacity))
  }
}

#Preview {
  VStack(spacing: 12) {
    W3WToast(text: "List updated") {}
    W3WToast(text: "Something went wrong", background: \.errorElevated) {}
  }
}
