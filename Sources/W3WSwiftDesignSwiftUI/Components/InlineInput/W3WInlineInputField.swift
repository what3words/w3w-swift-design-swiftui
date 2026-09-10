//
//  W3WInlineInputField.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Single-line entry docked above the keyboard with a character counter and a confirm tick.
/// Commits on Return or the tick while the text is non-blank and within the limit; reports
/// cancel when it leaves the screen.
@available(iOS 15, *)
public struct W3WInlineInputField: View {
  private let placeholder: String
  private let counterFormat: String
  private let characterLimit: Int
  @Binding private var text: String
  private let inputAccessibilityIdentifier: String?
  private let confirmAccessibilityIdentifier: String?
  private let confirmAccessibilityLabel: String?
  private let onCommit: () -> Void
  private let onCancel: () -> Void

  @FocusState private var focused: Bool

  /// - Parameters:
  ///   - counterFormat: two `%@` placeholders, used count then limit ("%@/%@ characters used")
  ///   - inputAccessibilityIdentifier: identifier for the text field, for UI tests
  ///   - confirmAccessibilityIdentifier: identifier for the tick button, for UI tests
  ///   - confirmAccessibilityLabel: translated VoiceOver label for the icon-only tick button
  public init(placeholder: String,
              counterFormat: String,
              characterLimit: Int = 255,
              text: Binding<String>,
              inputAccessibilityIdentifier: String? = nil,
              confirmAccessibilityIdentifier: String? = nil,
              confirmAccessibilityLabel: String? = nil,
              onCommit: @escaping () -> Void,
              onCancel: @escaping () -> Void) {
    self.placeholder = placeholder
    self.counterFormat = counterFormat
    self.characterLimit = characterLimit
    self._text = text
    self.inputAccessibilityIdentifier = inputAccessibilityIdentifier
    self.confirmAccessibilityIdentifier = confirmAccessibilityIdentifier
    self.confirmAccessibilityLabel = confirmAccessibilityLabel
    self.onCommit = onCommit
    self.onCancel = onCancel
  }

  private var isValid: Bool { text.count <= characterLimit }
  private var canCommit: Bool { isValid && !text.trimmingCharacters(in: .whitespaces).isEmpty }

  public var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack(spacing: 8) {
        TextField(placeholder, text: $text)
          .w3w(font: .body)
          .w3w(foreground: \.labelsPrimary)
          .focused($focused)
          .submitLabel(.go)
          .onSubmit { if canCommit { onCommit() } }
          .accessibilityIdentifier(optional: inputAccessibilityIdentifier)

        Button {
          if canCommit { onCommit() }
        } label: {
          Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 20))
            .w3w(foreground: canCommit ? \.fillsSecondary : \.labelsQuaternary)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier(optional: confirmAccessibilityIdentifier)
        .accessibilityLabel(optional: confirmAccessibilityLabel)
      }
      .padding(.horizontal, 14)
      .padding(.top, 12)

      Text(String(format: counterFormat, "\(text.count)", "\(characterLimit)"))
        .w3w(font: .footnote)
        .w3w(foreground: isValid ? \.labelsQuaternary : \.errorElevated)
        .padding(.horizontal, 14)
        .padding(.bottom, 8)
    }
    .w3w(background: \.groupedBackgroundBaseSecondary)
    .overlay(Color.clear.frame(height: 0.5).w3w(background: \.separatorNonOpaque), alignment: .top)
    .onAppear { focused = true }
    .onDisappear { onCancel() }
  }
}

@available(iOS 15, *)
#Preview {
  struct Host: View {
    @State var text = "Parking spots"
    var body: some View {
      VStack {
        Spacer()
        W3WInlineInputField(placeholder: "List name", counterFormat: "%@/%@ characters used", text: $text, onCommit: {}, onCancel: {})
      }
    }
  }
  return Host()
}
