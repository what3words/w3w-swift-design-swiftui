//
//  CloseButton.swift
//
//
//  Created by Thy Nguyen on 28/02/2024.
//

import SwiftUI

public struct W3WCloseButton: View {
  let size: CGFloat
  let inset: CGFloat
  let roundCorner: Bool
  let action: () -> Void
  
  init(size: CGFloat = 60.0,
       inset: CGFloat = 16.0,
       roundCorner: Bool = true,
       action: @escaping () -> Void) {
    self.size = size
    self.inset = inset
    self.roundCorner = roundCorner
    self.action = action
  }
  
  public var body: some View {
    Button(action: {
      action()
    }) {
      Image(uiImage: W3WImage.xmark.get())
        .resizable()
        .renderingMode(.template)
        .foregroundColor(.white)
        .padding(.all, inset + 8.0)
        .backgroundBlurEffect(W3WVisualEffect(style: .thin,
                                              fill: .fill,
                                              padding: W3WPadding(value: inset),
                                              cornerRadius: roundCorner ? W3WCornerRadius(value: (size - inset * 2.0) / 2.0) : 0.0))
    }
    .squareFrame(size)
  }
}
