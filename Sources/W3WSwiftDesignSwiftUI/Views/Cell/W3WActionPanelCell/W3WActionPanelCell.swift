//
//  SwiftUIView.swift
//  
//
//  Created by Khải Toàn Năng on 20/6/24.
//

import SwiftUI

struct W3WActionPanelCell<Content: View>: View {
  var iconImage: W3WImage?
  var uiImage: UIImage?
  var iconSize: CGFloat = 24
  var iconColor: Color?
  var title: String = ""
  var font: UIFont? = nil
  var forgroundColor: Color = .black
  var underlineText: String = ""
  var underlineAction: (() -> Void)?
  let rightItem: Content
  
  init(
    iconImage: W3WImage? = nil,
    uiImage: UIImage? = nil,
    iconSize: CGFloat = 24,
    iconColor: Color? = nil,
    title: String = "",
    font: UIFont? = nil,
    forgroundColor: Color = .black,
    underlineText: String = "",
    underlineAction: (() -> Void)? = nil,
    @ViewBuilder rightItem: () -> Content
  ) {
    self.iconImage = iconImage
    self.uiImage = uiImage
    self.iconSize = iconSize
    self.iconColor = iconColor
    self.title = title
    self.font = font
    self.forgroundColor = forgroundColor
    self.underlineText = underlineText
    self.underlineAction = underlineAction
    self.rightItem = rightItem()
  }

  var body: some View {
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
      icon
      titleText
      underline
    }
  }
  
  var titleText: some View {
    Text(title)
      .useFont(font)
      .foregroundColor(forgroundColor)
  }
  
  var underline: some View {
    Text(underlineText)
      .useFont(font)
      .underline()
      .foregroundColor(forgroundColor)
      .onTapGesture {
        underlineAction?()
      }
  }
  
  var icon: some View {
    W3WIconImage(
      iconImage: iconImage,
      uiImage: uiImage,
      iconSize: iconSize,
      color: iconColor ?? forgroundColor
    )
  }
}

#Preview {
  VStack {
    W3WActionPanelCell(
      iconImage: .accessibilityFill,
      title: "Without underline"
    ) {
    }
    W3WActionPanelCell(
      iconImage: .accessibilityFill,
      title: "With",
      underlineText: "underline"
    ) {
    }
    
    W3WActionPanelCell(
      iconImage: .arrowRight,
      iconColor: .blue,
      title: "With",
      underlineText: "underline and Left Item"
    ) {
      W3WTextButton(
        title: "Share",
        forgroundColor: .blue,
        font: .boldSystemFont(ofSize: 16)
      )
    }
  }
}
