//
//  W3WThreeWordAddressText.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// A three word address on one line: what3words-red "///" followed by the words.
/// Middle truncation keeps the first and last word readable when space runs out.
public struct W3WThreeWordAddressText: View {
  @Environment(\.theme) private var theme

  private let words: String
  private let font: W3WFontStyle
  private let weight: W3WFontWeight
  private let slashesWeight: W3WFontWeight

  /// - Parameter slashesWeight: the design keeps "///" one step lighter than the words
  public init(words: String,
              font: W3WFontStyle = .body,
              weight: W3WFontWeight = .semibold,
              slashesWeight: W3WFontWeight = .medium) {
    self.words = words
    self.font = font
    self.weight = weight
    self.slashesWeight = slashesWeight
  }

  public var body: some View {
    // the slashes are a brand mark: always what3words red, whatever the theme
    (Text("///").font(theme.font(font, weight: slashesWeight)).foregroundColor(W3WColor.w3wBrandBase.suColor)
     + Text(words).font(theme.font(font, weight: weight)).foregroundColor(theme.labelsTertiary))
      .lineLimit(1)
      .truncationMode(.middle)
  }
}

#Preview {
  VStack(alignment: .leading, spacing: 12) {
    W3WThreeWordAddressText(words: "filled.count.soap")
    W3WThreeWordAddressText(words: "universes.gardens.magically", font: .largeTitle)
    W3WThreeWordAddressText(words: "still.red.here")
      .modifyTheme { $0.brandBase = .standardBrandBase }
    W3WThreeWordAddressText(words: "extremely.overlong.threewordaddress.that.will.not.fit", font: .footnote, weight: .regular)
  }
  .padding()
}
