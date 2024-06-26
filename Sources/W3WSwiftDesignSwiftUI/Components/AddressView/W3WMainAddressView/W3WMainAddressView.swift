//
//  W3WMainAddressView.swift
//
//
//  Created by Khải Toàn Năng on 26/6/24.
//

import SwiftUI

struct W3WMainAddressView: View {
  var title: String = ""
  var subtitle: String = ""
  var action: (() -> Void) = {}
  
  init(
    title: String = "",
    subtitle: String = ""
  ) {
    self.title = title
    self.subtitle = subtitle
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        titleText
          .lineLimit(1)
          .minimumScaleFactor(0.5)
        Spacer()
        copyButton
      }
      subTitleText
        .lineLimit(1)
        .minimumScaleFactor(0.5)
    }
  }
}

// MARK: - View

private extension W3WMainAddressView {
  var titleText: some View {
    Text("///")
      .foregroundColor(Color.red)
    + Text(title)
      .foregroundColor(Color.black)
  }
  
  var subTitleText: some View {
    Text("///")
      .foregroundColor(Color.clear)
    + Text(subtitle)
      .foregroundColor(Color.black)
  }
  
  var copyButton: some View {
    Button {
      action()
    } label: {
      W3WIconImage(iconImage: .docOnDoc)
    }
  }
}

#Preview("Without Subtitle") {
  VStack {
    W3WMainAddressView(
      title: "Short title"
    )
    W3WMainAddressView(
      title: "Long title like thissssssssssssssssssssssssssssssssssssssssssssssssss"
    )
  }
  .padding()
}

#Preview("With Subtitle") {
  VStack {
    W3WMainAddressView(
      title: "Short title",
      subtitle: "Testing"
    )
    W3WMainAddressView(
      title: "Long title like thissssssssssssssssssssssssssssssssssssssssssssssssss",
      subtitle: "Testing"
    )
  }
  .padding()
}
