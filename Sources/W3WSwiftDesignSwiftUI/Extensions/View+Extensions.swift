//
//  File.swift
//  
//
//  Created by Khai Do on 19/02/2024.
//

import SwiftUI

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
      isVisible: Binding<Bool>,
      alignment: Alignment = .topTrailing,
      offsetX: CGFloat = 0,
      offsetY: CGFloat = 0,
      @ViewBuilder overlayView: @escaping () -> Overlay
  ) -> some View {
    self.modifier(CornerOverlayModifier(isVisible: isVisible, alignment: alignment,offsetX: offsetX, offsetY: offsetY, overlayView: overlayView))
  }
}
