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
  var shouldShowCopyButton: Bool = true
  var copyAction: (() -> Void) = {}
  var longPressCopyAction: (() -> Void) = {}
  var pressAction: (() -> Void) = {}
  var accessibilityLabel: String = ""
  var copyButtonAccessibilityLabel: String = ""
  
  @State private var textWidth: CGFloat = 0
  
  public init(
    theme: W3WTheme? = nil,
    title: String = "",
    subtitle: String = "",
    nearLocation: String = "",
    accessibilityLabel: String = "",
    copyButtonAccessibilityLabel: String = "",
    shouldShowNearLocation: Bool = false,
    shouldShowSecondaryPlaceholder: Bool = false,
    shouldShowCopyButton: Bool = true,
    copyAction: @escaping (() -> Void) = {},
    longPressCopyAction: @escaping (() -> Void) = {},
    pressAction: @escaping (() -> Void) = {}
  ) {
    self.theme = theme
    self.title = title
    self.subtitle = subtitle
    self.nearLocation = nearLocation
    self.shouldShowNearLocation = shouldShowNearLocation
    self.shouldShowSecondaryPlaceholder = shouldShowSecondaryPlaceholder
    self.shouldShowCopyButton = shouldShowCopyButton
    self.copyAction = copyAction
    self.longPressCopyAction = longPressCopyAction
    self.accessibilityLabel = accessibilityLabel
    self.copyButtonAccessibilityLabel = copyButtonAccessibilityLabel
    self.pressAction = pressAction
  }
  
  public var body: some View {
    HStack(alignment: .top) {
      if #available(iOS 14.0, *) {
        contentView
          .accessibilityLabel(accessibilityLabel)
          .contextMenu {
            Button("Copy") {
              longPressCopyAction()
            }
          }
      } else {
        contentView
          .accessibility(addTraits: .isButton)
          .accessibility(label: Text(accessibilityLabel))
          .contextMenu {
            Button("Copy") {
              longPressCopyAction()
            }
          }
      }
      
      Spacer()
      if shouldShowCopyButton {
        if #available(iOS 14.0, *) {
          copyButton
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(copyButtonAccessibilityLabel)
        } else {
          copyButton
            .accessibility(addTraits: .isButton)
            .accessibility(label: Text(copyButtonAccessibilityLabel))
        }
      }
    }
  }
}

// MARK: - View

private extension W3WMainAddressView {
  var contentView: some View {
    VStack(alignment: .leading, spacing: 0) {
      titleText
      
      if !subtitle.isEmpty {
        subtitleStack
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
    .accessibilityElement(children: .combine)
    .onTapGesture {
      pressAction()
    }
  }
  
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
    .minimumScaleFactor(0.2)
    .lineLimit(1)
    .layoutPriority(1)
    .scaledToFit()
    .frame(minHeight: 40)
    .cornerRadius(8, corners: .allCorners)
  }
  
  var subtitleStack: some View {
    HStack {
      Spacer().frame(width: textWidth)
      subTitleText
        .minimumScaleFactor(0.5)
        .lineLimit(1)
        .layoutPriority(0)
        .frame(minHeight: 32)
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
      .padding(W3WPadding.light.value)
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
      title: "Short title", longPressCopyAction:  {})
    W3WMainAddressView(
      title: "Long title like thissssssssssssssssssssssssssssssssssssssssssssssssss", longPressCopyAction:  {})
  }
  .padding()
}

#Preview("With Subtitle") {
  VStack {
    W3WMainAddressView(
      title: "Short title",
      subtitle: "Testing", longPressCopyAction:  {})
    W3WMainAddressView(
      title: "Long title like thissssssssssssssssssssssssssssssssssssssssssssssssss",
      subtitle: "Testing",
      longPressCopyAction:  {})
  }
  .padding()
}

