//
//  W3WSUCloseButton.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 02/10/2026.
//

import SwiftUI
import W3WSwiftThemes

/// In-content circular close button (SwiftUI counterpart of W3WCloseButton).
/// Colours come from the environment theme (`labelsPrimary` glyph on `fillsSenary`); pass `foreground` /
/// `background` to override, e.g. for a camera feed.
public struct W3WSUCloseButton: View {
  @Environment(\.theme) private var theme
  private let foreground: Color?
  private let background: Color?
  private let size: CGFloat
  private let iconSize: CGFloat
  private let accessibilityLabel: String?
  private let accessibilityIdentifier: String?
  private let onTap: () -> Void

  public init(foreground: Color? = nil,
              background: Color? = nil,
              size: CGFloat = 34,
              iconSize: CGFloat? = nil,
              accessibilityLabel: String? = nil,
              accessibilityIdentifier: String? = nil,
              onTap: @escaping () -> Void) {
    self.foreground = foreground
    self.background = background
    self.size = size
    self.iconSize = iconSize ?? size * 0.5
    self.accessibilityLabel = accessibilityLabel
    self.accessibilityIdentifier = accessibilityIdentifier
    self.onTap = onTap
  }

  public var body: some View {
    Button(action: onTap) {
      W3WIconImage(iconImage: W3WNavigationControl.close.image(for: .leftToRight),
                   iconSize: iconSize,
                   color: foreground ?? theme.labelsPrimary)
        .frame(width: size, height: size)
        .background(background ?? theme.fillsSenary ?? W3WCoreColor(hex: 0x7F7F7F).suColor.opacity(0.2))
        .clipShape(Circle())
    }
    .accessibilityLabel(accessibilityLabel ?? W3WNavigationControl.close.defaultAccessibilityLabel)
    .accessibilityIdentifier(accessibilityIdentifier ?? W3WNavigationControl.close.accessibilityIdentifier)
  }
}

#Preview {
  ZStack {
    Color.gray
    W3WSUCloseButton { }
  }
}
