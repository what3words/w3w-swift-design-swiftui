//
//  File.swift
//
//
//  Created by Khải Toàn Năng on 24/6/24.
//

import Foundation
import SwiftUI

public extension View {
  func backgroundMaterial(visualEffect: W3WVisualEffectBlur) -> some View {
    self.modifier(ViewMaterialModifier(visualEffect: visualEffect))
  }
}

struct ViewMaterialModifier: ViewModifier {
  var visualEffect: W3WVisualEffectBlur?
  
  func body(content: Content) -> some View {
    if #available(iOS 15.0, *) {
      if let material = getSystemMaterial(visualEffect) {
        content.background(material)
      } else {
        content.background(Color.white)
      }
    } else {
      content.background(Color.white)
    }
  }
  
  @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 10.0, *)
  func getSystemMaterial(_ visualEffect: W3WVisualEffectBlur?) -> Material?  {
    var material: Material?

    switch visualEffect {
      case .regular: material = .regular
      case .none: material = nil
      case .ultraThin: material = .ultraThin
      case .thin: material = .thin
      case .thick:  material = .thick
      case .ultraThick: material = .ultraThick
    }
    
    return material
  }
}

