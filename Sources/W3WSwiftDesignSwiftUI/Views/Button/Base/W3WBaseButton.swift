//
//  SwiftUIView.swift
//
//
//  Created by Khai Do on 7/6/24.
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
  var contentSpacing: CGFloat = 0
  var isCapsuleBackground: Bool = false
  var isExpandable: Bool = false
  var backgroundColor: Color = .blue
  var forgroundColor: Color = .white
  var borderColor: Color = .clear
  var borderWidth: CGFloat = 0
  var borderGradient: LinearGradient? = nil
  var backgroundGradient: LinearGradient? = nil
  var action: (() -> Void) = {}
  
  init(
    title: String = "",
    scheme: W3WScheme = .standard,
    iconImage: W3WImage? = nil,
    uiImage: UIImage? = nil,
    iconSize: CGFloat? = 24,
    contentSpacing: CGFloat = 0,
    horizontalPadding: CGFloat? = 16,
    verticalPadding: CGFloat? = 12,
    cornerRadius: CGFloat? = 8,
    isCapsuleBackground: Bool = false,
    isExpandable: Bool = false,
    backgroundColor: Color? = .blue,
    forgroundColor: Color? = .white,
    borderColor: Color = .clear,
    borderWidth: CGFloat = 0,
    borderGradient: LinearGradient? = nil,
    backgroundGradient: LinearGradient? = nil,
    action: (@escaping () -> Void) = {}
  ) {
    self.title = title
    self.scheme = scheme
    
    self.iconImage = iconImage
    self.uiImage = uiImage
    self.isCapsuleBackground = isCapsuleBackground
    self.isExpandable = isExpandable
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.contentSpacing = contentSpacing
    
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
    
    if let borderGradient {
      self.borderGradient = borderGradient
    }
    
    if let backgroundGradient {
      self.backgroundGradient = backgroundGradient
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
    titleView
      .background(backgroundView)
      .clipShape(backgroundShape)
      .overlay(borderOverlay)
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
  }
  
  var titleLabel: some View {
    HStack(spacing: contentSpacing) {
      icon
      if !title.isEmpty {
        Text(title)
          .font(scheme.styles?.font?.suFont)
          .fixedSize(horizontal: true, vertical: false)
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
  
  private var backgroundShape: some Shape {
    isCapsuleBackground
    ? AnyShape(Capsule())
    : AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
  }
  
  @ViewBuilder
  private var backgroundView: some View {
    if let backgroundGradient {
      backgroundGradient
    } else {
      backgroundColor
    }
  }
  
  @ViewBuilder
  private var borderOverlay: some View {
    if let borderGradient {
      backgroundShape
        .stroke(borderGradient, lineWidth: borderWidth)
        
    } else {
      backgroundShape
        .stroke(borderColor, lineWidth: borderWidth)
    }
  }
}

#Preview("Text Only Buttons") {
  ScrollView {
    VStack {
      W3WBaseButton(title: "Normal Button")
      W3WBaseButton(title: "Rounded Button", cornerRadius: 16)
      W3WBaseButton(title: "Capsule Button", isCapsuleBackground: true)
      W3WBaseButton(
        title: "Capsule Button with Border",
        isCapsuleBackground: true,
        borderColor: .red,
        borderWidth: 3
      )
      
      W3WBaseButton(
        title: "Normal Button with Border",
        isCapsuleBackground: false,
        borderColor: .green,
        borderWidth: 3
      )
      
      W3WBaseButton(
        title: "Background Gradient - Normal",
        backgroundGradient: LinearGradient(colors: [.red, .green], startPoint: .leading, endPoint: .trailing)
      )
      
      W3WBaseButton(
        title: "Background Gradient - Capsule",
        backgroundGradient: LinearGradient(colors: [.yellow, .blue], startPoint: .leading, endPoint: .trailing)
      )
      
      W3WBaseButton(
        title: "Background + Forground Gradient",
        borderWidth: 3,
        borderGradient: LinearGradient(colors: [.red, .black], startPoint: .leading, endPoint: .trailing),
        backgroundGradient: LinearGradient(colors: [.gray, .pink], startPoint: .leading, endPoint: .trailing)
      )
      
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
}

#Preview("Icon and Label Buttons") {
  ScrollView {
    VStack {
      W3WBaseButton(title: "W3WImage Button", iconImage: .cameraFill)
      W3WBaseButton(title: "UIImage Button", uiImage: .add)
      W3WBaseButton(title: "Rounded Button", iconImage: .badgeFill, cornerRadius: 16)
      W3WBaseButton(title: "Capsule Button", iconImage: .checkmark, isCapsuleBackground: true)
      W3WBaseButton(
        title: "Capsule Button with Border",
        isCapsuleBackground: true,
        borderColor: .red,
        borderWidth: 3
      )
      
      W3WBaseButton(
        title: "Normal Button with Border",
        isCapsuleBackground: false,
        borderColor: .green,
        borderWidth: 3
      )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
