//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 26/6/24.
//

import SwiftUI

struct W3WAlertContentView<ButtonView: View>: View {
  var title: String = ""
  var message: String = ""
  
  let buttonView: ButtonView
  
  init(
    title: String = "",
    message: String = "",
    @ViewBuilder buttonView: () -> ButtonView
  ) {
    self.title = title
    self.message = message
    self.buttonView = buttonView()
  }
  var body: some View {
    VStack {
      titleText
      messageText
      buttonView
    }
  }
}

private extension W3WAlertContentView {
  var titleText: some View {
    Text(title)
  }
  
  var messageText: some View {
    Text(message)
  }
}

#Preview {
  VStack {
    W3WAlertContentView(
      title: "This is title",
      message: "This is Message"
    ) {
      HStack {
        Button(action: {}, label: {
          Text("Delete")
        })
        Button(action: {}, label: {
          Text("Delete")
        })
      }
    }
  }
}
