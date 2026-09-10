//
//  View+OptionalAccessibility.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI

extension View {
  /// Applies the identifier when there is one; leaves the view untouched otherwise.
  @ViewBuilder
  func accessibilityIdentifier(optional identifier: String?) -> some View {
    if let identifier {
      if #available(iOS 14, *) {
        accessibilityIdentifier(identifier)
      } else {
        accessibility(identifier: identifier)
      }
    } else {
      self
    }
  }

  /// Applies the spoken label when there is one; leaves the view untouched otherwise.
  @ViewBuilder
  func accessibilityLabel(optional label: String?) -> some View {
    if let label {
      if #available(iOS 14, *) {
        accessibilityLabel(label)
      } else {
        accessibility(label: Text(label))
      }
    } else {
      self
    }
  }

  /// Marks the element selected for assistive tech when `selected` is true.
  @ViewBuilder
  func accessibilitySelected(_ selected: Bool) -> some View {
    if selected {
      if #available(iOS 14, *) {
        accessibilityAddTraits(.isSelected)
      } else {
        accessibility(addTraits: .isSelected)
      }
    } else {
      self
    }
  }
}
