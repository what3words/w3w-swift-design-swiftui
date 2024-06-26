//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 4/6/24.
//

import SwiftUI

public struct W3WIconImage: View {
  private(set) public var iconImage: W3WImage?
  private(set) public var uiImage: UIImage?
  private(set) public var iconSize: CGFloat = 24
  private(set) public var color: Color?
  private(set) public var font: Font?
  
  init(
    iconImage: W3WImage? = nil,
    uiImage: UIImage? = nil,
    iconSize: CGFloat = 24,
    color: Color? = nil
  ) {
    self.iconImage = iconImage
    self.uiImage = uiImage
    self.iconSize = iconSize
    self.color = color
  }
  
  public var body: some View {
    if let icon = iconImage {
      Image(uiImage: icon.get())
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .squareFrame(w3wImageSize)
        .foregroundColor(imageColor)
    } else if let image = uiImage {
      Image(uiImage: image)
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .squareFrame(uiImageSize)
        .foregroundColor(imageColor)
    } else {
      EmptyView()
    }
  }
}

private extension W3WIconImage {
  private var w3wImageSize: CGFloat {
    iconSize - 4
  }
  
  private var uiImageSize: CGFloat {
    iconSize
  }
  
  private var imageColor: Color {
    guard let color else {
      return .black
    }
    
    return color
  }
}

#Preview {
  W3WIconImage(
    iconImage: .camera
  )
}
