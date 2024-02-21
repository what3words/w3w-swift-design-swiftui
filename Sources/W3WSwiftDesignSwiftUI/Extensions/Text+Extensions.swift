//
//  File.swift
//  
//
//  Created by Huynh Tuan Khai Do on 21/02/2024.
//

import Foundation
import SwiftUI

extension Text {
  func useFont(_ uiFont: UIFont?) -> Text {
    if let uiFont {
      return self.font(Font(uiFont as CTFont))
    } else {
      return self
    }
  }
}
