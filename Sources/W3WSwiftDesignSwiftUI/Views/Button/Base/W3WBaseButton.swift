//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 7/6/24.
//

import SwiftUI
import W3WSwiftThemes

struct W3WBaseButton: View {
  var title: String = ""
  var font: Font = .body
  
  var iconImage: W3WImage?
  var uiImage: UIImage?

  var iconSize: CGFloat = 24
  var horizontalPadding: CGFloat = 16
  var verticalPadding: CGFloat = 12
  var cornerRadius: CGFloat = 8
  var isCapsuleBackground: Bool = false
  
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

private extension W3WBaseButton {
  @ViewBuilder
  var buttonLabel: some View {
    if isCapsuleBackground {
      titleLabel.clipShape(Capsule())
    } else {
      titleLabel.clipShape(
        RoundedRectangle(
          cornerRadius: cornerRadius
        )
      )
    }
  }
  
  @ViewBuilder
  var titleLabel: some View {
    HStack {
      icon
      Text(title)
        .font(font)
    }
    .foregroundColor(forgroundColor)
    .padding(.vertical, verticalPadding)
    .padding(.horizontal, horizontalPadding)
    .background(backgroundColor)
  }
  
  var icon: some View {
    W3WIconImage(
      iconImage: iconImage,
      uiImage: uiImage,
      iconSize: iconSize,
      color: forgroundColor
    )
  }
}

#Preview("Text Only Buttons") {
  VStack {
    W3WBaseButton(title: "Normal Button")
    W3WBaseButton(title: "Rounded Button", cornerRadius: 16)
    W3WBaseButton(title: "Capsule Button", isCapsuleBackground: true)
    W3WBaseButton(title: "Capsule Button", isCapsuleBackground: true).disabled(true)
  }
}

#Preview("Icon and Label Buttons") {
  VStack {
    W3WBaseButton(title: "W3WImage Button", iconImage: .cameraFill)
    W3WBaseButton(title: "UIImage Button", uiImage: .add)
    W3WBaseButton(title: "Rounded Button", iconImage: .badgeFill, cornerRadius: 16)
    W3WBaseButton(title: "Capsule Button", iconImage: .checkmark, isCapsuleBackground: true)
  }
}
