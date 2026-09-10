//
//  W3WScreenHeaderBar.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Screen header that replaces the system navigation bar: centred content over leading and
/// trailing action slots, 42pt tall, tinted with the quaternary fill.
public struct W3WScreenHeaderBar<Leading: View, Center: View, Trailing: View>: View {
  private let leading: Leading
  private let center: Center
  private let trailing: Trailing

  public init(@ViewBuilder leading: () -> Leading,
              @ViewBuilder center: () -> Center,
              @ViewBuilder trailing: () -> Trailing) {
    self.leading = leading()
    self.center = center()
    self.trailing = trailing()
  }

  public var body: some View {
    ZStack {
      center
      HStack {
        leading
        Spacer()
        trailing
      }
    }
    .frame(height: 42)
    .padding(.horizontal, 8)
    .w3w(background: \.fillsQuaternary)
  }
}

public extension W3WScreenHeaderBar where Center == W3WScreenHeaderTitle {
  /// Header with a plain single-line title in the centre.
  init(title: String,
       @ViewBuilder leading: () -> Leading,
       @ViewBuilder trailing: () -> Trailing) {
    self.init(leading: leading, center: { W3WScreenHeaderTitle(text: title) }, trailing: trailing)
  }
}

/// The header bar's default centre content.
public struct W3WScreenHeaderTitle: View {
  private let text: String

  public init(text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .w3w(font: .body, weight: .medium)
      .w3w(foreground: \.labelsTertiary)
      .lineLimit(1)
  }
}

#Preview {
  VStack(spacing: 20) {
    W3WScreenHeaderBar(title: "Saved locations") {
      EmptyView()
    } trailing: {
      W3WHeaderIconButton(systemName: "ellipsis") {}
    }

    W3WScreenHeaderBar {
      W3WHeaderIconButton(systemName: "chevron.left") {}
    } center: {
      W3WThreeWordAddressText(words: "filled.count.soap")
    } trailing: {
      HStack(spacing: 14) {
        Image(systemName: "square.fill")
          .font(.system(size: 15))
          .foregroundColor(W3WColor.w3wBrandBase.suColor)
          .frame(width: 24, height: 24)
        W3WHeaderIconButton(systemName: "ellipsis") {}
      }
    }
  }
}
