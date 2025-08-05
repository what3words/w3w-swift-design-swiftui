//
//  File.swift
//  
//
//  Created by Huynh Tuan Khai Do on 21/02/2024.
//

import Foundation
import SwiftUI
import W3WSwiftThemes

public extension Text {
  /**
   Apply nullable UIFont to SwiftUI Text
   - parameters:
        - uiFont: Nullable UIFont
   */
  func useFont(_ uiFont: UIFont?) -> Text {
    if let uiFont {
      return self.font(Font(uiFont as CTFont))
    } else {
      return self
    }
  }
  
  /**
   Apply W3WScheme that will affect font and forgroundColor of the Text
   - parameters:
        - scheme: Nullable what3words scheme
   */
  func scheme(_ scheme: W3WScheme?) -> some View {
    Group {
      if let scheme {
        return self
          .font(scheme.styles?.font?.suFont)
          .foregroundColor(scheme.colors?.foreground?.suColor ?? .black)
      } else {
        return self
      }
    }
  }
}
