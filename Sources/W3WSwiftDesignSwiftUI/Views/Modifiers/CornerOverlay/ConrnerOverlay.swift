//
//  ConrnerOverlay.swift
//  w3w-swift-design-swiftui
//
//  Created by Khai Do on 11/4/25.
//

import SwiftUI

struct CornerOverlayModifier<Overlay: View>: ViewModifier {
  @Binding var isVisible: Bool
  let alignment: Alignment
  let offsetX: CGFloat
  let offsetY: CGFloat
  let overlayView: () -> Overlay
  
  func body(content: Content) -> some View {
    ZStack(alignment: alignment) {
      content
      if isVisible {
        overlayView()
          .offset(x: offsetX, y: offsetY)
          .transition(.opacity)
      }
    }
  }
}
