//
//  W3WCountBadge.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Neutral capsule for a count ("3", "100+") at the trailing edge of a row.
public struct W3WCountBadge: View {
  private let text: String

  public init(text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .w3w(font: .caption2)
      .w3w(foreground: \.labelsSecondary)
      .padding(6)
      .w3w(background: \.fillsSenary)
      .clipShape(Capsule())
  }
}

#Preview {
  HStack {
    W3WCountBadge(text: "3")
    W3WCountBadge(text: "100+")
  }
  .padding()
}
