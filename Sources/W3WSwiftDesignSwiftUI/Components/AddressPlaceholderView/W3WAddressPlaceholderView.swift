//
//  SwiftUIView.swift
//
//
//  Created by Khai Do on 1/8/24.
//

import SwiftUI

public struct W3WAddressPlaceholderView: View {
  var color: Color
  
  public init(color: Color? = .clear) {
    self.color = color ?? .clear
  }
  
  public var body: some View {
    HStack {
      dashView
      circleView
      dashView
      circleView
      dashView
    }
  }
  
  
  var dashView: some View {
    Rectangle()
      .fill(color)
      .frame(height: 4)
  }
  
  var circleView: some View {
    Circle()
      .fill(color)
      .frame(width: 8, height: 8)
  }
}

#Preview {
  W3WAddressPlaceholderView(color: .blue)
}
