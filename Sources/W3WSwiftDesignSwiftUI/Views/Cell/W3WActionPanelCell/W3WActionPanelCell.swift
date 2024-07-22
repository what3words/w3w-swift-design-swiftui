//
//  SwiftUIView.swift
//  
//
//  Created by Khải Toàn Năng on 20/6/24.
//

import SwiftUI

public struct W3WActionPanelCell<Content: View>: View {
  var theme: W3WTheme?
  var iconImage: W3WImage?
  var uiImage: UIImage?
  var iconSize: CGFloat = 24
  var iconColor: Color?
  var title: String = ""
  var underlineText: String = ""
  var underlineAction: (() -> Void)?
  let rightItem: Content
  
  public init(
    theme: W3WTheme?,
    iconImage: W3WImage? = nil,
    uiImage: UIImage? = nil,
    iconSize: CGFloat = 24,
    iconColor: Color? = nil,
    title: String = "",
    underlineText: String = "",
    underlineAction: (() -> Void)? = nil,
    @ViewBuilder rightItem: () -> Content
  ) {
    self.theme = theme
    self.iconImage = iconImage
    self.uiImage = uiImage
    self.iconSize = iconSize
    self.iconColor = iconColor
    self.title = title
    self.underlineText = underlineText
    self.underlineAction = underlineAction
    self.rightItem = rightItem()
  }

  public var body: some View {
    contentView
  }
}

// MARK: - Views

extension W3WActionPanelCell {
  var contentView: some View  {
    HStack {
      leftItemView
      Spacer()
      rightItem
    }
  }
  
  var leftItemView: some View {
    HStack(spacing: 4) {
      iconView
      titleView
      underlineView
    }
  }
  
  var titleView: some View {
    Text(title)
      .font(labelScheme?.styles?.font?.suFont)
      .foregroundColor(labelScheme?.colors?.foreground?.suColor)
  }
  
  var underlineView: some View {
    Text(underlineText)
      .font(labelScheme?.styles?.font?.suFont)
      .underline()
      .foregroundColor(labelScheme?.colors?.foreground?.suColor)
      .onTapGesture {
        underlineAction?()
      }
  }
  
  var iconView: some View {
    VStack {
      if iconImage != nil || uiImage != nil {
        W3WIconImage(
          iconImage: iconImage,
          uiImage: uiImage,
          iconSize: iconSize,
          color: iconColor ?? defaultImageColor
        )
      } else {
        W3WIconImage(
          iconImage: .listBullet,
          uiImage: nil,
          iconSize: iconSize,
          color: defaultImageColor
        )
      }
    }
  }
}

private extension W3WActionPanelCell {
  private var labelScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .callout, weight: .regular)
  }
  
  private var actionLabelScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .callout, weight: .regular)
  }
  
  private var defaultImageColor: Color? {
    theme?.labelsSecondary?.suColor
  }
}

#Preview {
  VStack {
    W3WActionPanelCell(
      theme: .what3words,
      iconImage: .accessibilityFill,
      iconColor: .red,
      title: "Without underline"
    ) {
    }
    
    W3WActionPanelCell(
      theme: .what3words,
      iconImage: .accessibilityFill,
      title: "With",
      underlineText: "underline"
    ) {
    }
    
    W3WActionPanelCell(
      theme: .what3words,
      title: "Without Image",
      underlineText: "underline"
    ) {
    }
    
    W3WActionPanelCell(
      theme: .what3words,
      iconImage: .arrowRight,
      iconColor: .blue,
      title: "With",
      underlineText: "underline and Left Item"
    ) {
    }
  }
}
