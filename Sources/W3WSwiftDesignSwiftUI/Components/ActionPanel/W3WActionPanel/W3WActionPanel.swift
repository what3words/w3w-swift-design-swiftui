//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 12/6/24.
//

import SwiftUI
import W3WSwiftThemes

struct W3WActionPanel<Content: View>: View {
  var shouldShowNavBar: Bool = false
  var navBarTitle: String = ""
  var navBarBackgroundColor: Color = .blue
  var navBarForgroundColor: Color = .black
  var navBarFont: UIFont? = nil
  var cornerRadius: CGFloat = 8
  let content: Content

  init(
    shouldShowNavBar: Bool = false,
    navBarTitle: String = "",
    navBarBackgroundColor: Color = .blue,
    navBarForgroundColor: Color = .black,
    font: UIFont? = nil,
    cornerRadius: CGFloat = 8,
    @ViewBuilder content: () -> Content
  ) {
    self.shouldShowNavBar = shouldShowNavBar
    self.navBarTitle = navBarTitle
    self.navBarBackgroundColor = navBarBackgroundColor
    self.cornerRadius = cornerRadius
    self.content = content()
  }
  
  var body: some View {
    contentView
  }
}

// MARK: - Views

private extension W3WActionPanel {
  var contentView: some View {
    VStack(spacing: 0) {
      if shouldShowNavBar {
        navBarView
      }
      content
    }
    .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])
  }
  
  var navBarView: some View {
    HStack {
      W3WIconImage(
        iconImage: .chevronLeft,
        color: navBarForgroundColor
      )
      Text(navBarTitle)
        .useFont(navBarFont)
        .foregroundColor(navBarForgroundColor)
      Spacer()
      W3WIconImage(
        iconImage: .xmark,
        iconSize: 16,
        color: navBarForgroundColor
      )
    }
    .padding(8)
    .background(navBarBackgroundColor)
  }
}

#Preview("Action Panel with NavBar") {
  W3WActionPanel(
    shouldShowNavBar: true,
    navBarTitle: "Testing",
    cornerRadius: 8
  ) {
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
}

#Preview("Action Panel with NavBar") {
  W3WActionPanel(
    shouldShowNavBar: false,
    navBarTitle: "Testing",
    cornerRadius: 8
  ) {
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
}
