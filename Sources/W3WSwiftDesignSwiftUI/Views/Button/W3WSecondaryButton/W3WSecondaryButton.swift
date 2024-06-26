//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 11/6/24.
//

import SwiftUI
import W3WSwiftThemes

struct W3WSecondaryButton: View {
  var scheme: W3WScheme? = nil
  let title: String = ""
  
  var body: some View {
    W3WBaseButton(
      title: title,
      backgroundColor: backgroundColor,
      forgroundColor: forgroundColor
    )
  }
}

// MARK: - Getters

private extension W3WSecondaryButton {
  var backgroundColor: Color {
    // TODO
    .green
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
  W3WSecondaryButton()
}
