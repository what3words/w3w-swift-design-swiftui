//
//  W3WOverlayBottomSheet.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 18/8/25.
//

import SwiftUI
import W3WSwiftThemes
import UIKit

public struct W3WOverlayBottomSheet<Content: View>: View {
  public var overlayColor: Color
  @ViewBuilder public let content: Content
  
  var onDismiss: (() -> Void)?
  public init(overlayColor: Color = W3WColor.overlayNormal.suColor,
              @ViewBuilder content: () -> Content,
              onDismiss: (() -> Void)?) {
    self.overlayColor = overlayColor
    self.content = content()
    self.onDismiss = onDismiss
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        overlayColor.edgesIgnoringSafeArea(.all)
          .onTap {
            onDismiss?()
          }
        VStack {
          Spacer() // push everything to bottom
          VStack(spacing: 0) {
            Spacer()
              .frame(height: 10.0)
            Rectangle()
              .fill(W3WCoreColor(hex: 0x7F7F7F).suColor.opacity(0.4))
              .cornerRadius(4.0)
              .frame(width: 36.0, height: 5.0)
            content
              .edgesIgnoringSafeArea(.bottom)
          }
          .background(backgroundColor)
          .cornerRadius(W3WCornerRadius.regular.value, corners: [.topLeft, .topRight])
        }
        .background(
          background // Hackaround to force a background at the bottom area
            .frame(height: geometry.safeAreaInsets.bottom)
            .frame(maxHeight: .infinity, alignment: .bottom)
        )
      }
    }
  }
  
  // hackaround background
  private var background: some View {
    return backgroundColor.edgesIgnoringSafeArea(.bottom)
  }
  
  private var backgroundColor: Color {
    W3WColor.w3wSystemBackgroundElevatedPrimary.suColor
  }
}
