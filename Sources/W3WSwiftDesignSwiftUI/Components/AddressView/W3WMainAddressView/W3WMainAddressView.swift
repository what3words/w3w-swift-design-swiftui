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
  var nearLocation: String = ""
  var shouldShowNearLocation: Bool = false
  var shouldShowSecondaryPlaceholder: Bool = false
  var copyAction: (() -> Void) = {}
  
  public init(
    theme: W3WTheme? = nil,
    title: String = "",
    subtitle: String = "",
    nearLocation: String = "",
    shouldShowNearLocation: Bool = false,
    copyAction: @escaping (() -> Void) = {}
  ) {
    self.theme = theme
    self.title = title
    self.subtitle = subtitle
    self.nearLocation = nearLocation
    self.shouldShowNearLocation = shouldShowNearLocation
    self.copyAction = copyAction
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        titleText
          .minimumScaleFactor(0.5)
          .lineLimit(1)
          .layoutPriority(1)
          .frame(minHeight: 40)
        Spacer()
        copyButton
      }
      .accessibilityElement()
      if !subtitle.isEmpty {
        subTitleText
          .minimumScaleFactor(0.5)
          .lineLimit(1)
          .layoutPriority(0)
          .frame(minHeight: 40)
      }
      
      if shouldShowSecondaryPlaceholder {
        addressPlaceHolder
      }
      
      if shouldShowNearLocation {
        nearLocationText
      }
    }
  }
}

// MARK: - View

private extension W3WMainAddressView {
  var titleText: some View {
    dashText
    + Text(title)
      .foregroundColor(titleScheme?.colors?.foreground?.current.suColor)
      .font(titleScheme?.styles?.font?.suFont)
  }
  
  var subTitleText: some View {
    clearDashText
    + Text(subtitle)
      .foregroundColor(subtitleScheme?.colors?.foreground?.current.suColor)
      .font(subtitleScheme?.styles?.font?.suFont)
  }
  
  var nearLocationText: some View {
    clearDashText
    + Text(nearLocation)
      .foregroundColor(subtitleScheme?.colors?.foreground?.current.suColor)
      .font(subtitleScheme?.styles?.font?.suFont)
  }
  
  var dashText: Text {
    Text("///")
      .foregroundColor(theme?.brandBase?.current.suColor)
      .font(titleScheme?.styles?.font?.suFont)
  }
  
  var clearDashText: Text {
    Text("///")
      .foregroundColor(.clear)
      .font(titleScheme?.styles?.font?.suFont)
  }

  var copyButton: some View {
    Button {
      copyAction()
    } label: {
      W3WIconImage(
        iconImage: .docOnDoc,
        color: titleScheme?.colors?.foreground?.current.suColor
      )
    }
  }
  
  var addressPlaceHolder: some View {
    HStack {
      clearDashText
      W3WAddressPlaceholderView(color: theme?.labelsQuaternary?.suColor)
    }
  }
}

private extension W3WMainAddressView {
  var titleScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .largeTitle, weight: .semibold)
  }
  
  var subtitleScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .title2, weight: .regular)
  }
}

#Preview("Without Subtitle") {
  VStack {
    W3WMainAddressView(
      title: "Short title"
    ) {}
    W3WMainAddressView(
      title: "Long title like thissssssssssssssssssssssssssssssssssssssssssssssssss"
    ) {}
  }
  .padding()
}

#Preview("With Subtitle") {
  VStack {
    W3WMainAddressView(
      title: "Short title",
      subtitle: "Testing"
    ) {}
    W3WMainAddressView(
      title: "Long title like thissssssssssssssssssssssssssssssssssssssssssssssssss",
      subtitle: "Testing"
    ) {}
  }
  .padding()
}

