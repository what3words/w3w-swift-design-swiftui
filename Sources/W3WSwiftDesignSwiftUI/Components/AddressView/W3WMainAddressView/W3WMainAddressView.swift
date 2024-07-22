//
//  W3WMainAddressView.swift
//
//
//  Created by Khải Toàn Năng on 26/6/24.
//

import SwiftUI
import W3WSwiftThemes

public struct W3WMainAddressView: View {
  var theme: W3WTheme?
  var title: String = ""
  var subtitle: String = ""
  var action: (() -> Void) = {}
  
  public init(
    theme: W3WTheme? = nil,
    title: String = "",
    subtitle: String = ""
  ) {
    self.theme = theme
    self.title = title
    self.subtitle = subtitle
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        titleText
          .lineLimit(1)
          .minimumScaleFactor(0.5)
        Spacer()
        copyButton
      }
      if !subtitle.isEmpty {
        subTitleText
          .lineLimit(1)
          .minimumScaleFactor(0.5)
      }
    }
  }
}

// MARK: - View

private extension W3WMainAddressView {
  var titleText: some View {
    Text("///")
      .foregroundColor(theme?.brandBase?.suColor)
      .font(titleScheme?.styles?.font?.suFont)
    + Text(title)
      .foregroundColor(titleScheme?.colors?.foreground?.suColor)
      .font(titleScheme?.styles?.font?.suFont)
  }
  
  var subTitleText: some View {
    Text("///")
      .foregroundColor(Color.clear)
      .font(subtitleScheme?.styles?.font?.suFont)
    + Text(subtitle)
      .foregroundColor(Color.black)
      .font(subtitleScheme?.styles?.font?.suFont)
  }
  
  var copyButton: some View {
    Button {
      action()
    } label: {
      W3WIconImage(iconImage: .docOnDoc)
    }
  }
}

private extension W3WMainAddressView {
  var titleScheme: W3WScheme? {
    let scheme = W3WTheme.what3words.labelScheme(grade: .tertiary, fontStyle: .largeTitle, weight: .black)
    return scheme
  }
  
  var subtitleScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .body, weight: .black)
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
