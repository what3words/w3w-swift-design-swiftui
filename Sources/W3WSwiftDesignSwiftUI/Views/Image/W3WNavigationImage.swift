//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 23/02/2024.
//

import SwiftUI

public struct W3WNavigationImage: View {
  @Environment(\.layoutDirection) var layoutDirection
  
  public init() {}
  
  public var body: some View {
    if layoutDirection == .leftToRight {
      Image(uiImage: W3WImage.chevronRight.get())
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
    } else {
      Image(uiImage: W3WImage.chevronLeft.get())
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
    }
  }
}

#Preview {
  W3WNavigationImage()
}
