//
//  W3WListDivider.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Hairline separator between list rows; full width by default, inset when the caller asks.
public struct W3WListDivider: View {
  private let leadingInset: CGFloat

  public init(leadingInset: CGFloat = 0) {
    self.leadingInset = leadingInset
  }

  public var body: some View {
    Color.clear
      .frame(height: 0.5)
      .w3w(background: \.separatorNonOpaque)
      .padding(.leading, leadingInset)
      .w3w(background: \.systemBackgroundElevatedPrimary)
  }
}

#Preview {
  VStack(spacing: 20) {
    W3WListDivider()
    W3WListDivider(leadingInset: 16)
    W3WListDivider(leadingInset: 54)
  }
}
