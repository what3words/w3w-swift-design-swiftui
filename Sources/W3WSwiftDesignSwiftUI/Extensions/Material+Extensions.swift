//
//  File.swift
//
//
//  Created by Khải Toàn Năng on 24/6/24.
//

import Foundation
import SwiftUI

public enum ViewMaterial {
  /// A material matching the style of system toolbars.
  case bar
  
  /// A material that's somewhat translucent.
  case regular
  
  /// A material that's more opaque than translucent.
  case thick
  
  /// A material that's more translucent than opaque.
  case thin
  
  /// A mostly translucent material.
  case ultraThin
  
  /// A mostly opaque material.
  case ultraThick
  
  /// A material that's somewhat translucent.
  case regularMaterial
  
  /// A material that's more opaque than translucent.
  case thickMaterial
  
  /// A material that's more translucent than opaque.
  case thinMaterial
  
  /// A mostly translucent material.
  case ultraThinMaterial
  
  /// A mostly opaque material.
  case ultraThickMaterial
}

public extension View {
  func backgroundMaterial(viewMaterial: ViewMaterial) -> some View {
    self.modifier(ViewMaterialModifier(viewMaterial: viewMaterial))
  }
}

struct ViewMaterialModifier: ViewModifier {
  var viewMaterial: ViewMaterial?
  
  func body(content: Content) -> some View {
    if #available(iOS 15.0, *) {
      if let material = getSystemMaterial(viewMaterial) {
        content.background(material)
      } else {
        content.background(Color.white)
      }
    } else {
      content.background(Color.white)
    }
  }
  
  @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 10.0, *)
  func getSystemMaterial(_ viewMaterial: ViewMaterial?) -> Material?  {
    var material: Material?
    
    switch viewMaterial {
    case .bar: material = .bar
    case .regular: material = .regular
    case .thick: material = .thick
    case .thin: material = .thin
    case .ultraThin: material = .ultraThin
    case .ultraThick: material = .ultraThick
    case .regularMaterial: material = .regularMaterial
    case .thickMaterial: material = .thickMaterial
    case .thinMaterial: material = .thinMaterial
    case .ultraThinMaterial: material = .ultraThinMaterial
    case .ultraThickMaterial: material = .ultraThickMaterial
    default: material = nil
    }
    
    return material
  }
}

