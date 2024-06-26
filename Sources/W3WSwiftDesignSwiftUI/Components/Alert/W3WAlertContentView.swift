//
//  SwiftUIView.swift
//  
//
//  Created by Khải Toàn Năng on 26/6/24.
//

import SwiftUI

struct W3WAlertContentView: View {
  var title: String = ""
  var message: String = ""

  var primaryButtonTitle: String = ""
  var secondaryButtonTittle: String = ""
  var primaryAction: (() -> Void) = {}
  var secondaryAction: (() -> Void) = {}
  
    var body: some View {
      VStack {
        titleText
        messageText
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
  
  var primaryButton: some View {
    W3WPrimaryButton(scheme: nil, title: primaryButtonTitle)
  }
}

#Preview {
  W3WAlertContentView()
}
