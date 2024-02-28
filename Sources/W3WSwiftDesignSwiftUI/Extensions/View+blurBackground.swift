//
//  View+blurBackground.swift
//  
//
//  Created by Thy Nguyen on 28/02/2024.
//

import SwiftUI

extension View {
  func backgroundBlurEffect(_ visualEffect: W3WVisualEffect) -> some View {
    background(
      BlurView(visualEffect: visualEffect)
        .padding(.all, visualEffect.padding.value)
    )
  }
}
