//
//  SwiftUIView.swift
//
//
//  Created by Khai Do on 12/6/24.
//

import SwiftUI
import W3WSwiftThemes

public struct ScrollableHStack<Content: View>: View {
  var spacing: CGFloat? = nil
  var horizontalPadding: CGFloat = 0
  var verticalPadding: CGFloat = 0
  let content: Content
  
  @State private var contentSize: CGSize = .zero
  
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
    contentView
  }
}

// MARK: - Getters

private extension ScrollableHStack {
  var contentView: some View {
    HorizontalAxisGeometryReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: spacing) {
          content
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
        .frame(minWidth: proxy)
      }
    }
  }
}

#Preview("None scroll") {
  ScrollableHStack {
    W3WSUButton(
      title: "Share",
      iconImage: .squareAndArrowUp,
      scheme: W3WTheme.what3words.buttonScheme(grade: .primary, shape: .large),
      action: {}
    )
    W3WSUButton(
      title: "Navigate",
      iconImage: .arrowTriangleTurnUpRightDiamond,
      scheme:  W3WTheme.what3words.buttonScheme(grade: .secondary, shape: .large),
      isExpandable: true,
      action: {}
    )
    W3WSUButton(
      title: "Save",
      iconImage: .star,
      scheme:  W3WTheme.what3words.buttonScheme(grade: .secondary, shape: .large),
      action: {}
    )
  }
}

#Preview("Scroll") {
  ScrollableHStack {
    W3WSUButton(
      title: "Share",
      iconImage: .squareAndArrowUp,
      scheme: W3WTheme.what3words.buttonScheme(grade: .primary, shape: .large),
      action: {}
    )
    W3WSUButton(
      title: "Navigate",
      iconImage: .arrowTriangleTurnUpRightDiamond,
      scheme:  W3WTheme.what3words.buttonScheme(grade: .secondary, shape: .large),
      isExpandable: true,
      action: {}
    )
    W3WSUButton(
      title: "Save",
      iconImage: .star,
      scheme:  W3WTheme.what3words.buttonScheme(grade: .secondary, shape: .large),
      action: {}
    )
    W3WSUButton(
      title: "Saved",
      iconImage: .starFill,
      scheme:  W3WTheme.what3words.buttonScheme(grade: .secondary, shape: .large),
      action: {}
    )
  }
}
