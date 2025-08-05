//
//  File.swift
//
//
//  Created by Khai Do on 24/6/24.
//

import Foundation
import SwiftUI

struct SizeReactiveModifier: ViewModifier {
  @Binding var size: CGSize
  
  func body(content: Content) -> some View {
    content
      .background(
        GeometryReader { geometry -> Color in
          DispatchQueue.main.async {
            self.size = geometry.size
          }
          return Color.clear
        }
      )
  }
}

public extension View {
  func onContentSizeChange(_ size: Binding<CGSize>) -> some View {
    self.modifier(SizeReactiveModifier(size: size))
  }
}

