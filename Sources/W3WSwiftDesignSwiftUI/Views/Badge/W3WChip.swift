//
//  W3WChip.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Small tinted label ("w3w HCMC"). The tint is the caller's data colour (a list colour, a tag);
/// the text is always white so it reads on any saturated tint in both colour schemes.
public struct W3WChip: View {
  private let text: String
  private let color: W3WColor
  private let cornerRadius: CGFloat

  public init(text: String, color: W3WColor, cornerRadius: CGFloat = 0) {
    self.text = text
    self.color = color
    self.cornerRadius = cornerRadius
  }

  public var body: some View {
    Text(text)
      .w3w(font: .caption1)
      .foregroundColor(W3WColor.w3wLabelsPrimaryWhite.suColor)
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(RoundedRectangle(cornerRadius: cornerRadius).fill(color.suColor))
  }
}

#Preview {
  HStack {
    W3WChip(text: "w3w HCMC", color: .w3wBrandBase)
    W3WChip(text: "Parking", color: W3WColor(all: W3WCoreColor(hex: 0x2E71B8)))
  }
  .padding()
}
