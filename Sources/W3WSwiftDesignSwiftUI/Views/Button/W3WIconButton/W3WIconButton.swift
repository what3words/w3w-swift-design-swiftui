//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 10/6/24.
//

import SwiftUI

struct W3WIconButton: View {
  var iconImage: W3WImage?
  var uiImage: UIImage?
  
  var iconSize: CGFloat = 24
  var padding: CGFloat = 12
  
  var backgroundColor: Color = .blue
  var forgroundColor: Color = .white
  
  var action: (() -> Void) = {}
  
  var body: some View {
    Button(
      action: { action() },
      label: {
        buttonLabel
      }
    )
  }
}

// MARK: - Views

private extension W3WIconButton {
  @ViewBuilder
  var buttonLabel: some View {
    icon
      .padding(padding)
      .background(backgroundColor)
      .clipShape(Circle())
  }
  
  var icon: some View {
    VStack {
      if let iconImage {
        W3WIconImage(
          iconImage: iconImage,
          iconSize: iconSize,
          color: forgroundColor
        )
      }
      
      if let uiImage {
        W3WIconImage(
          uiImage: uiImage,
          iconSize: iconSize,
          color: forgroundColor
        )
      }
    }
  }
}

#Preview("UIImage Buttons") {
  VStack {
    W3WIconButton(uiImage: .add)
    W3WIconButton(uiImage: .remove, iconSize: 36)
    W3WIconButton(uiImage: .checkmark, padding: 24)
  }
}

#Preview("Icon Buttons") {
  VStack {
    W3WIconButton(iconImage: .cameraFill)
    W3WIconButton(iconImage: .chevronBackward, iconSize: 36)
    W3WIconButton(iconImage: .checkmark, padding: 24)
  }
}
