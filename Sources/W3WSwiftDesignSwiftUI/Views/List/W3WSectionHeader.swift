//
//  W3WSectionHeader.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// List section title ("My lists"): bold footnote in the quaternary label colour on the
/// base-secondary background, closed by a hairline.
public struct W3WSectionHeader: View {
  private let title: String

  public init(title: String) {
    self.title = title
  }

  public var body: some View {
    HStack {
      Text(title)
        .w3w(font: .footnote, weight: .bold)
        .w3w(foreground: \.labelsQuaternary)
      Spacer()
    }
    .padding(.horizontal, 16)
    .frame(height: 32)
    .w3w(background: \.systemBackgroundBaseSecondary)
    .overlay(Color.clear.frame(height: 0.5).w3w(background: \.separatorNonOpaque), alignment: .bottom)
  }
}

#Preview {
  W3WSectionHeader(title: "My lists")
}
