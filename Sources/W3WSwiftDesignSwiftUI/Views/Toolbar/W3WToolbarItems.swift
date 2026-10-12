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
  private let tint: Color?
  private let accessibilityLabel: String?
  private let accessibilityIdentifier: String?
  private let action: () -> Void

  /// `tint` overrides the theme colour; `accessibilityIdentifier` overrides the shared one when a screen already has a UI-test tag.
  public init(placement: ToolbarItemPlacement = .topBarLeading,
              tint: Color? = nil,
              accessibilityLabel: String? = nil,
              accessibilityIdentifier: String? = nil,
              action: @escaping () -> Void) {
    self.placement = placement
    self.tint = tint
    self.accessibilityLabel = accessibilityLabel
    self.accessibilityIdentifier = accessibilityIdentifier
    self.action = action
  }

  public var body: some ToolbarContent {
    W3WNavigationToolbarItem(control: .close, placement: placement, tint: tint, accessibilityLabel: accessibilityLabel,
                             accessibilityIdentifier: accessibilityIdentifier, action: action)
  }
}

/// Back chevron toolbar item, mirrored for RTL, without the Liquid Glass background.
public struct W3WBackToolbarItem: ToolbarContent {
  private let placement: ToolbarItemPlacement
  private let tint: Color?
  private let accessibilityLabel: String?
  private let accessibilityIdentifier: String?
  private let action: () -> Void

  /// `tint` overrides the theme colour; `accessibilityIdentifier` overrides the shared one when a screen already has a UI-test tag.
  public init(placement: ToolbarItemPlacement = .topBarLeading,
              tint: Color? = nil,
              accessibilityLabel: String? = nil,
              accessibilityIdentifier: String? = nil,
              action: @escaping () -> Void) {
    self.placement = placement
    self.tint = tint
    self.accessibilityLabel = accessibilityLabel
    self.accessibilityIdentifier = accessibilityIdentifier
    self.action = action
  }

  public var body: some ToolbarContent {
    W3WNavigationToolbarItem(control: .back, placement: placement, tint: tint, accessibilityLabel: accessibilityLabel,
                             accessibilityIdentifier: accessibilityIdentifier, action: action)
  }
}

struct W3WNavigationToolbarItem: ToolbarContent {
  let control: W3WNavigationControl
  let placement: ToolbarItemPlacement
  let tint: Color?
  let accessibilityLabel: String?
  let accessibilityIdentifier: String?
  let action: () -> Void

  var body: some ToolbarContent {
    // The bar draws the system glass circle (Design, 2026-10-12), so the button itself stays flat here.
    ToolbarItem(placement: placement) {
      W3WNavigationControlButton(control: control, tint: tint, glass: false, accessibilityLabel: accessibilityLabel,
                                 accessibilityIdentifier: accessibilityIdentifier, action: action)
    }
  }
}

/// The close / back glyph button on its own, for custom header bars that are not a toolbar.
/// Reads the theme and layout direction from the environment; `tint` overrides the theme colour.
/// `glass` draws the system glass circle behind the glyph on iOS 26+ (plain glyph on earlier systems).
public struct W3WNavigationControlButton: View {
  /// Diameter of the glass circle, matching the system bar item.
  public static let glassSize: CGFloat = 44

  @Environment(\.theme) private var theme
  @Environment(\.layoutDirection) private var layoutDirection
  @Environment(\.colorScheme) private var colorScheme
  private let control: W3WNavigationControl
  private let tint: Color?
  private let glass: Bool
  private let iconSize: CGFloat
  private let accessibilityLabel: String?
  private let accessibilityIdentifier: String?
  private let action: () -> Void

  public init(control: W3WNavigationControl,
              tint: Color? = nil,
              glass: Bool = true,
              iconSize: CGFloat = 24,
              accessibilityLabel: String? = nil,
              accessibilityIdentifier: String? = nil,
              action: @escaping () -> Void) {
    self.control = control
    self.tint = tint
    self.glass = glass
    self.iconSize = iconSize
    self.accessibilityLabel = accessibilityLabel
    self.accessibilityIdentifier = accessibilityIdentifier
    self.action = action
  }

  public var body: some View {
    Button(action: action) {
      W3WIconImage(iconImage: control.image(for: layoutDirection),
                   iconSize: iconSize,
                   color: tint ?? W3WNavigationControl.glyphTint(for: colorScheme, theme: theme))
        .frame(width: glass ? Self.glassSize : nil, height: glass ? Self.glassSize : nil)
    }
    .modifier(GlassCircle(enabled: glass))
    .accessibilityLabel(accessibilityLabel ?? control.defaultAccessibilityLabel)
    .accessibilityIdentifier(accessibilityIdentifier ?? control.accessibilityIdentifier)
  }
}

/// System glass circle behind a standalone control; nothing before iOS 26.
private struct GlassCircle: ViewModifier {
  let enabled: Bool

  func body(content: Content) -> some View {
    if enabled, #available(iOS 26.0, *) {
      content.glassEffect(.regular.interactive(), in: .circle)
    } else {
      content
    }
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
