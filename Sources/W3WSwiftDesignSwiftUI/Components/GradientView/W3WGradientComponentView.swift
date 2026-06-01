//
//  W3WGradientView.swift
//  w3w-swift-design-swiftui
//
//  Created by Khai Do on 28/1/26.
//

import SwiftUI

public struct W3WGradientComponentView<Content: View>: View {
  let content: Content
  let gradient: LinearGradient
  
  public init(
    gradient: LinearGradient,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.gradient = gradient
  }
  
  public var body: some View {
    content
      .foregroundColor(.clear)
      .overlay(gradient)
      .mask(
        content
      )
  }
}
