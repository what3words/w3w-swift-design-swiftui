//
//  W3WToolbarItems.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 02/10/2026.
//

import SwiftUI

/// Close (X) toolbar item without the Liquid Glass tinted circle, tinted from the environment theme.
public struct W3WCloseToolbarItem: ToolbarContent {
  private let placement: ToolbarItemPlacement
  private let accessibilityLabel: String?
  private let accessibilityIdentifier: String?
  private let action: () -> Void

  /// `accessibilityIdentifier` overrides the shared one when a screen already has a UI-test tag.
  public init(placement: ToolbarItemPlacement = .topBarLeading,
              accessibilityLabel: String? = nil,
              accessibilityIdentifier: String? = nil,
              action: @escaping () -> Void) {
    self.placement = placement
    self.accessibilityLabel = accessibilityLabel
    self.accessibilityIdentifier = accessibilityIdentifier
    self.action = action
  }

  public var body: some ToolbarContent {
    W3WNavigationToolbarItem(control: .close, placement: placement, accessibilityLabel: accessibilityLabel,
                             accessibilityIdentifier: accessibilityIdentifier, action: action)
  }
}

/// Back chevron toolbar item, mirrored for RTL, without the Liquid Glass background.
public struct W3WBackToolbarItem: ToolbarContent {
  private let placement: ToolbarItemPlacement
  private let accessibilityLabel: String?
  private let accessibilityIdentifier: String?
  private let action: () -> Void

  /// `accessibilityIdentifier` overrides the shared one when a screen already has a UI-test tag.
  public init(placement: ToolbarItemPlacement = .topBarLeading,
              accessibilityLabel: String? = nil,
              accessibilityIdentifier: String? = nil,
              action: @escaping () -> Void) {
    self.placement = placement
    self.accessibilityLabel = accessibilityLabel
    self.accessibilityIdentifier = accessibilityIdentifier
    self.action = action
  }

  public var body: some ToolbarContent {
    W3WNavigationToolbarItem(control: .back, placement: placement, accessibilityLabel: accessibilityLabel,
                             accessibilityIdentifier: accessibilityIdentifier, action: action)
  }
}

struct W3WNavigationToolbarItem: ToolbarContent {
  let control: W3WNavigationControl
  let placement: ToolbarItemPlacement
  let accessibilityLabel: String?
  let accessibilityIdentifier: String?
  let action: () -> Void

  var body: some ToolbarContent {
    if #available(iOS 26.0, *) {
      ToolbarItem(placement: placement) {
        W3WNavigationControlButton(control: control, accessibilityLabel: accessibilityLabel,
                                   accessibilityIdentifier: accessibilityIdentifier, action: action)
      }
      .sharedBackgroundVisibility(.hidden)
    } else {
      ToolbarItem(placement: placement) {
        W3WNavigationControlButton(control: control, accessibilityLabel: accessibilityLabel,
                                   accessibilityIdentifier: accessibilityIdentifier, action: action)
      }
    }
  }
}

/// The close / back glyph button on its own, for custom header bars that are not a toolbar.
/// Reads the theme and layout direction from the environment; `tint` overrides the theme colour.
public struct W3WNavigationControlButton: View {
  @Environment(\.theme) private var theme
  @Environment(\.layoutDirection) private var layoutDirection
  private let control: W3WNavigationControl
  private let tint: Color?
  private let iconSize: CGFloat
  private let accessibilityLabel: String?
  private let accessibilityIdentifier: String?
  private let action: () -> Void

  public init(control: W3WNavigationControl,
              tint: Color? = nil,
              iconSize: CGFloat = 24,
              accessibilityLabel: String? = nil,
              accessibilityIdentifier: String? = nil,
              action: @escaping () -> Void) {
    self.control = control
    self.tint = tint
    self.iconSize = iconSize
    self.accessibilityLabel = accessibilityLabel
    self.accessibilityIdentifier = accessibilityIdentifier
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      W3WIconImage(iconImage: control.image(for: layoutDirection),
                   iconSize: iconSize,
                   color: tint ?? W3WNavigationControl.tint(from: theme))
    }
    .accessibilityLabel(accessibilityLabel ?? control.defaultAccessibilityLabel)
    .accessibilityIdentifier(accessibilityIdentifier ?? control.accessibilityIdentifier)
  }
}

public extension View {
  /// Adds a themed close item that calls `action`.
  func w3wCloseToolbarItem(placement: ToolbarItemPlacement = .topBarLeading,
                           accessibilityLabel: String? = nil,
                           action: @escaping () -> Void) -> some View {
    toolbar { W3WCloseToolbarItem(placement: placement, accessibilityLabel: accessibilityLabel, action: action) }
  }

  /// Hides the system back button and adds a themed back item that calls `action`.
  func w3wBackToolbarItem(placement: ToolbarItemPlacement = .topBarLeading,
                          accessibilityLabel: String? = nil,
                          action: @escaping () -> Void) -> some View {
    navigationBarBackButtonHidden()
      .toolbar { W3WBackToolbarItem(placement: placement, accessibilityLabel: accessibilityLabel, action: action) }
  }
}
