//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 12/6/24.
//

import SwiftUI

public struct ScrollableHStack<Content: View>: View {
  var spacing: CGFloat? = nil
  var horizontalPadding: CGFloat = 0
  var verticalPadding: CGFloat = 0
  let content: Content
  
  public init(
    spacing: CGFloat? = 8,
    horizontalPadding: CGFloat = 0,
    verticalPadding: CGFloat = 0,
    @ViewBuilder content: () -> Content
  ) {
    self.spacing = spacing
    self.horizontalPadding = horizontalPadding
    self.verticalPadding = verticalPadding
    self.content = content()
  }
  
  public var body: some View {
    GeometryReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: spacing) {
          content
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
        .frame(minWidth: proxy.size.width)
      }
    }
  }
}
#Preview("None scroll") {
  ScrollableHStack {
    Text("Testing 0")
    Spacer()
    Text("Testing 1")
    Spacer()
    Text("Testing 2")
  }
}

#Preview("Scroll") {
  ScrollableHStack {
    Text("Testing 0")
    Text("Testing 1")
    Text("Testing 2")
    Text("Testing 3")
    Text("Testing 4")
    Text("Testing 5")
  }
}
