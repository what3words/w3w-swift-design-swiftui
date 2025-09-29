//
//  W3WOverlayBottomSheetData.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 29/9/25.
//

import SwiftUI

/// Environment key/value for configuring `W3WOverlayBottomSheet`.
extension EnvironmentValues {
  /// Configuration data for the overlay bottom sheet.
  ///
  /// Defaults:
  /// - `overlayColor`: `W3WCoreColor.darkBlueAlpha60.suColor`
  /// - `showDragIndicator`: `true`
  /// - `cornerRadius`: `W3WCornerRadius.regular.value`
  @Entry var overlayBottomSheetData = W3WOverlayBottomSheetData()
}

/// Configuration model for `W3WOverlayBottomSheet`.
///
/// Includes:
/// - `overlayColor`: The background overlay color behind the sheet (typically a dimmed color).
/// - `showDragIndicator`: Whether to show a small drag handle at the top of the sheet.
/// - `cornerRadius`: Corner radius for the top corners of the sheet.
///
/// Read inside `W3WOverlayBottomSheet` via `@Environment(\.overlayBottomSheetData)`.
struct W3WOverlayBottomSheetData {
  /// The full-screen overlay color behind the sheet.
  ///
  /// Used to dim or obscure the underlying content. Commonly set to `Color.black.opacity(x)`.
  var overlayColor = W3WCoreColor.darkBlueAlpha60.suColor
  
  /// Controls visibility of the small drag indicator at the top of the sheet.
  ///
  /// Set to `true` to show, `false` to hide.
  var showDragIndicator = true
  
  /// Corner radius applied to the sheet's top-left and top-right corners.
  var cornerRadius: CGFloat = W3WCornerRadius.regular.value
}
