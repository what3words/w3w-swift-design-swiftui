//
//  SwiftUIView.swift
//  
//
//  Created by Khải Toàn Năng on 11/6/24.
//

import SwiftUI
import W3WSwiftThemes

struct W3WPrimaryButton: View {
  var scheme: W3WScheme? = nil
  var title: String = ""
  
  var body: some View {
    W3WBaseButton(
      title: title,
      backgroundColor: backgroundColor,
      forgroundColor: forgroundColor
    )
  }
}

// MARK: - Getters

private extension W3WPrimaryButton {
  var backgroundColor: Color {
    // TODO
    .blue
  }
  
  var forgroundColor: Color {
    // TODO
    .black
  }
  
  var cornerRadius: CGFloat {
    // TODO
    8
  }
}

#Preview {
  W3WPrimaryButton()
}
