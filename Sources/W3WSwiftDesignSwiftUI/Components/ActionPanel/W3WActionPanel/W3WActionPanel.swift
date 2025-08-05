//
//  SwiftUIView.swift
//
//
//  Created by Khai Do on 12/6/24.
//

import SwiftUI
import W3WSwiftThemes

public struct W3WActionPanel<NavBarContent: View, Content: View>: View {
  var shouldShowNavBar: Bool = false
  var cornerRadius: CGFloat = 8
  let navBar: NavBarContent
  let content: Content

  public init(
    shouldShowNavBar: Bool = false,
    cornerRadius: CGFloat = 8,
    @ViewBuilder navigationBar: @escaping () -> NavBarContent,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.shouldShowNavBar = shouldShowNavBar
    self.cornerRadius = cornerRadius
    self.content = content()
    self.navBar = navigationBar()
  }
  
  public var body: some View {
    contentView
  }
}

// MARK: - Views

private extension W3WActionPanel {
  var contentView: some View {
    VStack(spacing: 0) {
      if shouldShowNavBar {
        navBar
      }
      content
    }
    .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])
  }
}

#Preview("Action Panel with NavBar") {
  W3WActionPanel(
    shouldShowNavBar: false,
    cornerRadius: 8,
    navigationBar: {
      EmptyView()
    },
    content: {
      VStack {
        Text("Testing")
        Text("Testing")
        Text("Testing")
        Text("Testing")
        Text("Testing")
        Text("Testing")
      }
      .frame(maxWidth: .infinity)
      .background(Color.green)
    }
  )
}

#Preview("Action Panel without NavBar") {
  W3WActionPanel(
    shouldShowNavBar: true,
    cornerRadius: 8,
    navigationBar: {
      HStack {
        W3WIconImage(
          iconImage: .chevronLeft,
          color: .red
        )
        Text("Back")
          .foregroundColor(.green)
        Spacer()
        W3WIconImage(
          iconImage: .xmark,
          iconSize: 16,
          color: .blue
        )
      }
      .padding(8)
      .background(Color.yellow)
    }, content:  {
      ScrollableHStack {
        Text("Testing")
        Text("Testing")
        Text("Testing")
        Text("Testing")
      }
      .frame(maxWidth: .infinity)
      .background(Color.green)
    }
  )
}
