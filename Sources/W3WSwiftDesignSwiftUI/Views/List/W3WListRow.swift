//
//  W3WListRow.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Tappable row shell for list screens: full width, 16pt insets, 56pt minimum height,
/// elevated primary background. The row's own content goes in the builder.
public struct W3WListRow<Content: View>: View {
  private let minHeight: CGFloat
  private let action: () -> Void
  private let content: Content

  public init(minHeight: CGFloat = 56, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
    self.minHeight = minHeight
    self.action = action
    self.content = content()
  }

  public var body: some View {
    Button(action: action) {
      content
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
        .w3w(background: \.systemBackgroundElevatedPrimary)
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  VStack(spacing: 0) {
    W3WListRow(action: {}) {
      HStack(spacing: 8) {
        Image(systemName: "heart.fill")
          .font(.system(size: 17))
          .foregroundColor(W3WColor.w3wBrandBase.suColor)
          .frame(width: 30, height: 30)
        Text("Favourites").w3w(font: .body).w3w(foreground: \.labelsTertiary)
        Spacer()
        HStack(spacing: 4) {
          W3WCountBadge(text: "12")
          Image(systemName: "chevron.forward").font(.system(size: 17)).w3w(foreground: \.labelsSecondary)
        }
      }
    }
    W3WListDivider()
    W3WListRow(action: {}) {
      Text("Add a new list").w3w(font: .body).w3w(foreground: \.labelsTertiary)
    }
  }
}
