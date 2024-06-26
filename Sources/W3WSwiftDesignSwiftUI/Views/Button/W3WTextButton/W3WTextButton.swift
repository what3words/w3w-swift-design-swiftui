//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 20/6/24.
//

import SwiftUI

struct W3WTextButton: View {
  var title: String = ""
  var forgroundColor: Color = .black
  var font: UIFont? = .systemFont(ofSize: 12)
  var action: (() -> Void)? = {}
  
  var body: some View {
    Button(
      action: { action?() },
      label: {
        Text(title)
          .useFont(font)
          .foregroundColor(forgroundColor)
      }
    )
  }
}

#Preview {
  VStack {
    W3WTextButton(
      title: "Normal Text Button",
      forgroundColor: .red,
      font: .systemFont(ofSize: 24, weight: .regular)
    )
    
    W3WTextButton(
      title: "Medium Text Button",
      forgroundColor: .green,
      font: .systemFont(ofSize: 24, weight: .medium)
    )
    
    W3WTextButton(
      title: "Black Text Button",
      forgroundColor: .blue,
      font: .systemFont(ofSize: 24, weight: .black)
    )
  }
}
