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
  private let action: () -> Void

  public init(placement: ToolbarItemPlacement = .topBarLeading,
              accessibilityLabel: String? = nil,
              action: @escaping () -> Void) {
    self.placement = placement
    self.accessibilityLabel = accessibilityLabel
    self.action = action
  }

  public var body: some ToolbarContent {
    W3WNavigationToolbarItem(control: .close, placement: placement, accessibilityLabel: accessibilityLabel, action: action)
  }
}

/// Back chevron toolbar item, mirrored for RTL, without the Liquid Glass background.
public struct W3WBackToolbarItem: ToolbarContent {
  private let placement: ToolbarItemPlacement
  private let accessibilityLabel: String?
  private let action: () -> Void

  public init(placement: ToolbarItemPlacement = .topBarLeading,
              accessibilityLabel: String? = nil,
              action: @escaping () -> Void) {
    self.placement = placement
    self.accessibilityLabel = accessibilityLabel
    self.action = action
  }

  public var body: some ToolbarContent {
    W3WNavigationToolbarItem(control: .back, placement: placement, accessibilityLabel: accessibilityLabel, action: action)
  }
}

struct W3WNavigationToolbarItem: ToolbarContent {
  let control: W3WNavigationControl
  let placement: ToolbarItemPlacement
  let accessibilityLabel: String?
  let action: () -> Void

  var body: some ToolbarContent {
    if #available(iOS 26.0, *) {
      ToolbarItem(placement: placement) {
        W3WNavigationControlButton(control: control, accessibilityLabel: accessibilityLabel, action: action)
      }
      .sharedBackgroundVisibility(.hidden)
    } else {
      ToolbarItem(placement: placement) {
        W3WNavigationControlButton(control: control, accessibilityLabel: accessibilityLabel, action: action)
      }
    }
  }
}

/// The button inside the toolbar item; a View so it can read the theme and layout direction.
struct W3WNavigationControlButton: View {
  @Environment(\.theme) private var theme
  @Environment(\.layoutDirection) private var layoutDirection
  let control: W3WNavigationControl
  let accessibilityLabel: String?
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      W3WIconImage(iconImage: control.image(for: layoutDirection),
                   color: W3WNavigationControl.tint(from: theme))
    }
    .accessibilityLabel(accessibilityLabel ?? control.defaultAccessibilityLabel)
    .accessibilityIdentifier(control.accessibilityIdentifier)
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
