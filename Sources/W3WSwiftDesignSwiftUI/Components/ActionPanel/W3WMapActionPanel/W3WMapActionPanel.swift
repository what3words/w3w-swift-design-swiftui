//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 25/6/24.
//

import SwiftUI

public struct W3WMapActionPanel: View {
  @State private var texts: [String] = ["Initial Content"]
  
  public init() {}
  
  public var body: some View {
    W3WActionPanel() {
      contentView
    }
  }
}

// MARK: - Views

private extension W3WMapActionPanel {
  var contentView: some View {
    VStack {
      textStackView
      buttonView
    }
    .frame(maxWidth: .infinity)
    .background(Color.red)
  }
  
  var textStackView: some View {
    ForEach(texts, id: \.self) { text in
      Text(text)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
    }
  }
  
  var buttonView: some View {
    Button(action: {
      addNewText()
    }) {
      Text("Add Text")
        .padding()
        .background(Color.yellow)
        .cornerRadius(10)
    }
  }
  
  private func addNewText() {
    texts.append("New Content \(texts.count + 1)")
    // Force update of heightPublisher when new text is added
  }
}

#Preview {
  W3WMapActionPanel()
}
