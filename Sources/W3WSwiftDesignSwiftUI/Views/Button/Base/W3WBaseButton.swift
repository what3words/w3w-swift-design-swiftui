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
  var scheme: W3WScheme = .standard
  var iconImage: W3WImage?
  var uiImage: UIImage?
  var iconSize: CGFloat = 24
  var horizontalPadding: CGFloat = 16
  var verticalPadding: CGFloat = 12
  var cornerRadius: CGFloat = 8
  var isCapsuleBackground: Bool = false
  var isExpandable: Bool = false
  var backgroundColor: Color = .blue
  var forgroundColor: Color = .white
  
  var action: (() -> Void) = {}
  
  init(
    title: String = "",
    scheme: W3WScheme = .standard,
    iconImage: W3WImage? = nil,
    uiImage: UIImage? = nil,
    iconSize: CGFloat? = 24,
    horizontalPadding: CGFloat? = 16,
    verticalPadding: CGFloat? = 12,
    cornerRadius: CGFloat? = 8,
    isCapsuleBackground: Bool = false,
    isExpandable: Bool = false,
    backgroundColor: Color? = .blue,
    forgroundColor: Color? = .white,
    action: (@escaping () -> Void) = {}
  ) {
    self.title = title
    self.scheme = scheme

    self.iconImage = iconImage
    self.uiImage = uiImage
    self.isCapsuleBackground = isCapsuleBackground
    self.isExpandable = isExpandable
    
    if let iconSize {
      self.iconSize = iconSize
    }

    if let horizontalPadding {
      self.horizontalPadding = horizontalPadding
    }
    
    if let verticalPadding {
      self.verticalPadding = verticalPadding
    }

    if let cornerRadius {
      self.cornerRadius = cornerRadius
    }

    if let backgroundColor {
      self.backgroundColor = backgroundColor
    }

    if let forgroundColor {
      self.forgroundColor = forgroundColor
    }

    self.action = action
  }
  
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
      titleView.clipShape(Capsule())
    } else {
      titleView.clipShape(
        RoundedRectangle(
          cornerRadius: cornerRadius
        )
      )
    }
  }
  
  var titleView: some View {
    HStack {
      if isExpandable {
        Spacer(minLength: horizontalPadding)
        titleLabel
        Spacer(minLength: horizontalPadding)
      } else {
        titleLabel
          .padding(.horizontal, horizontalPadding)
      }
    }
    .background(backgroundColor)
  }
  
  var titleLabel: some View {
    HStack {
      icon
      if !title.isEmpty {
        Text(title)
          .font(scheme.styles?.font?.suFont)
      }
    }
    .foregroundColor(forgroundColor)
    .padding(.vertical, verticalPadding)

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
