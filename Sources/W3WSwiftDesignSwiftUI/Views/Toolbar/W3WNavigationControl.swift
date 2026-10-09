//
//  W3WNavigationControl.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 02/10/2026.
//

import SwiftUI
import W3WSwiftThemes

/// One definition of the close and back controls so toolbar items and close buttons share the glyph, identifier and tint.
/// Mirrors `W3WNavigationControl` in w3w-swift-design; keep the two in sync.
public enum W3WNavigationControl {
  case close
  case back

  /// Glyph for the control; the back chevron follows the layout direction because SF chevrons do not mirror on their own.
  public func image(for layoutDirection: LayoutDirection) -> W3WImage {
    switch self {
    case .close: return .xmark
    case .back: return layoutDirection == .rightToLeft ? .chevronRight : .chevronLeft
    }
  }

  public var accessibilityIdentifier: String {
    switch self {
    case .close: return "navigation_bar_close"
    case .back: return "navigation_bar_back"
    }
  }

  /// English fallback only; callers pass a translated label.
  public var defaultAccessibilityLabel: String {
    switch self {
    case .close: return "Close"
    case .back: return "Back"
    }
  }

  /// Tint for nav bar close/back buttons: the theme's dark-blue label colour (navy in light mode, near-white in dark).
  public static func tint(from theme: W3WSwiftUITheme) -> Color? {
    theme.labelsTertiary
  }
}
