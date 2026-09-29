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
/// Never narrower than it is tall, so a short count is a circle and only longer ones stretch.
public struct W3WCountBadge: View {
  private let text: String
  @State private var height: CGFloat = 0

  private enum Measured: Hashable { case badge }

  public init(text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .w3w(font: .caption2)
      .w3w(foreground: \.labelsSecondary)
      .padding(6)
      .onHeightChange($height, for: Measured.badge)
      .frame(minWidth: height)
      .w3w(background: \.fillsSenary)
      .clipShape(Capsule())
  }
}

#Preview {
  HStack {
    W3WCountBadge(text: "3")       // circle
    W3WCountBadge(text: "15")      // circle
    W3WCountBadge(text: "100+")    // stretched
    W3WCountBadge(text: "1000+")   // stretched further
  }
  .padding()
}
