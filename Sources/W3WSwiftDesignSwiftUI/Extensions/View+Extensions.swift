//
//  File.swift
//  
//
//  Created by Khai Do on 19/02/2024.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftThemes

public extension View {
  
  /**
   Make a Square Frame for SwiftUI view
   - parameters:
        - size: width and height of the square Frame
   */
  func squareFrame(_ size: CGFloat) -> some View {
    self.frame(width: size, height: size)
  }
  
  /**
   Add Specific corner radius to specific corner for SwiftUI view
   - parameters:
        - radius: Corner radius
        - corners: Specify the corner to reshapre
   */
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
      clipShape( RoundedCorner(radius: radius, corners: corners) )
  }
  
  /**
   Add an overlay on top of current view
   - parameters:
        - isVisible: should the overlay be visible or not
        - alignment: Overlay view placement
        - offsetX: Offset of the overlay on the X axis
        - offsetY: Offset of the overlay on the Y axis
        - overlayView: The overlay View on top of the current View
   */
  func cornerOverlay<Overlay: View>(
      isVisible: Bool,
      alignment: Alignment = .topTrailing,
      offsetX: CGFloat = 0,
      offsetY: CGFloat = 0,
      @ViewBuilder overlayView: @escaping () -> Overlay
  ) -> some View {
    self.modifier(CornerOverlayModifier(isVisible: isVisible, alignment: alignment,offsetX: offsetX, offsetY: offsetY, overlayView: overlayView))
  }
  
  /**
   Add shadow to view
   - parameters:
        - value: a config value that helps generate shadow
   */
  func shadow(
    color: W3WColor,
    style: W3WShadow
  ) -> some View {
    self.shadow(
      color: color.suColor.opacity(Double(style.opacity)),
      radius: style.radius,
      x: style.offsetX,
      y: style.offsetY
    )
  }
}

// MARK: - Layout Direction
public extension View {
  /// Sets the SwiftUI view's layout direction based on the current
  /// `UIView.appearance().semanticContentAttribute`.
  ///
  /// This lets the SwiftUI hierarchy adapt automatically to the global
  /// UIKit appearance settings (e.g., force right-to-left).
  ///
  /// - Returns: A view with the applied layout direction.
  func layoutDirectionFromAppearance() -> some View {
    environment(\.layoutDirection, {
      switch UIView.appearance().semanticContentAttribute {
      case .forceRightToLeft: return .rightToLeft
      default: return .leftToRight
      }
    }())
  }
  
  /// Sets the SwiftUI view's layout direction based on a `W3WLanguage`'s writing direction.
  ///
  /// Use this if you want your layout to match the text direction of a specific language,
  /// regardless of the system's or UIKit's global appearance.
  ///
  /// - Parameter language: A `W3WLanguage` instance; if nil or direction unknown, defaults to left-to-right.
  /// - Returns: A view with the applied layout direction.
  func layoutDirection(for language: W3WLanguage?) -> some View {
    environment(\.layoutDirection, {
      switch language?.direction() {
      case .rightToLeft: .rightToLeft
      default: .leftToRight
      }
    }())
  }
}

//MARK: - Convenient extensions
public extension View {
  @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
    if shouldHide { self.hidden() } else { self }
  }
}
