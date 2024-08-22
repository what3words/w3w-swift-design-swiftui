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
  
  @State private var textWidth: CGFloat = 0
  
  public init(
    theme: W3WTheme? = nil,
    title: String = "",
    subtitle: String = "",
    nearLocation: String = "",
    shouldShowNearLocation: Bool = false,
    shouldShowSecondaryPlaceholder: Bool = false,
    copyAction: @escaping (() -> Void) = {}
  ) {
    self.theme = theme
    self.title = title
    self.subtitle = subtitle
    self.nearLocation = nearLocation
    self.shouldShowNearLocation = shouldShowNearLocation
    self.shouldShowSecondaryPlaceholder = shouldShowSecondaryPlaceholder
    self.copyAction = copyAction
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        titleText
          .minimumScaleFactor(0.5)
          .lineLimit(1)
          .layoutPriority(1)
          .scaledToFit()
          .frame(minHeight: 40)
        Spacer()
        copyButton
      }
      .accessibilityElement()
      
      if !subtitle.isEmpty {
        HStack {
          Spacer().frame(width: textWidth)
          subTitleText
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .layoutPriority(0)
            .frame(minHeight: 32)
        }
      }
      
      if shouldShowSecondaryPlaceholder {
        HStack {
          Spacer().frame(width: textWidth)
          addressPlaceHolder
        }
      }
      
      if shouldShowNearLocation {
        HStack {
          Spacer().frame(width: textWidth)
          nearLocationText
        }
      }
    }
    .accessibilityElement()
  }
}

// MARK: - View

private extension W3WMainAddressView {
  var titleText: some View {
    HStack(spacing: 0) {
      Text("///")
        .foregroundColor(theme?.brandBase?.current.suColor)
        .font(titleScheme?.styles?.font?.suFont)
        .background(GeometryReader { geometry in
          Color.clear
            .onAppear {
              textWidth = geometry.size.width
            }
        })
      Text(title)
        .foregroundColor(titleScheme?.colors?.foreground?.current.suColor)
        .font(titleScheme?.styles?.font?.suFont)
    }
  }
  
  var subTitleText: some View {
    Text(subtitle)
      .foregroundColor(subtitleScheme?.colors?.foreground?.current.suColor)
      .font(subtitleScheme?.styles?.font?.suFont)
  }
  
  var nearLocationText: some View {
    Text(nearLocation)
      .foregroundColor(subtitleScheme?.colors?.foreground?.current.suColor)
      .font(subtitleScheme?.styles?.font?.suFont)
  }
  
  var dashText: Text {
    Text("///")
      .foregroundColor(theme?.brandBase?.current.suColor)
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
    W3WAddressPlaceholderView(color: theme?.labelsQuaternary?.suColor)
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

