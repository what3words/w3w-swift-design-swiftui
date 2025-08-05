//
//  ConrnerOverlay.swift
//  w3w-swift-design-swiftui
//
//  Created by Khai Do on 11/4/25.
//

import SwiftUI

struct CornerOverlayModifier<Overlay: View>: ViewModifier {
  var isVisible: Bool
  let alignment: Alignment
  let offsetX: CGFloat
  let offsetY: CGFloat
  let overlayView: Overlay
  
  init(
    isVisible: Bool = true,
    alignment: Alignment = .topTrailing,
    offsetX: CGFloat = 0,
    offsetY: CGFloat = 0,
    @ViewBuilder overlayView: @escaping () -> Overlay
  ) {
    self.isVisible = isVisible
    self.alignment = alignment
    self.offsetX = offsetX
    self.offsetY = offsetY
    self.overlayView = overlayView()
  }
  
  func body(content: Content) -> some View {
    ZStack(alignment: alignment) {
      content
      if isVisible {
        overlayView
          .offset(x: offsetX, y: offsetY)
          .transition(.opacity)
      }
    }
  }
}

#Preview {
  let overlay = W3WIconImage(
    iconImage: .slashes,
    iconSize: 16,
    color: .white
  ).padding(4).background(Color.red).clipShape(Circle())

  
  ScrollableHStack {
    HStack {
      W3WSUButton(title: "Top Left", scheme: .buttonPrimaryLarge())
        .cornerOverlay(isVisible: true, alignment: .topLeading, offsetX: -6, offsetY: -6 ,overlayView: {
          overlay
        })
      W3WSUButton(title: "Top Right", scheme: .buttonPrimaryLarge())
        .cornerOverlay(isVisible: true, alignment: .topTrailing, offsetX: 6, offsetY: -6 ,overlayView: {
          overlay
        })
      W3WSUButton(title: "Bottom Left", scheme: .buttonPrimaryLarge())
        .cornerOverlay(isVisible: true, alignment: .bottomLeading, offsetX: -6, offsetY: 6 ,overlayView: {
          overlay
        })
      W3WSUButton(title: "Bottom Right", scheme: .buttonPrimaryLarge())
        .cornerOverlay(isVisible: true, alignment: .bottomTrailing, offsetX: 6, offsetY: 6 ,overlayView: {
          overlay
        })
      W3WSUButton(title: "No offset", scheme: .buttonPrimaryLarge())
        .cornerOverlay(isVisible: true,overlayView: {
          overlay
        })
    }
    .background(Color.green)
    .padding(.vertical, 8)
  }
}
