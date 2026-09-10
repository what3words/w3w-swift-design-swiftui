//
//  W3WMenuRow.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import Foundation

/// One row of a `W3WMenuList`: glyph + title.
public struct W3WMenuRow: Identifiable, Equatable {
  public let id: String
  public let title: String
  public let systemImage: String
  /// identifier for UI tests; nil applies none
  public let accessibilityIdentifier: String?

  public init(id: String,
              title: String,
              systemImage: String,
              accessibilityIdentifier: String? = nil) {
    self.id = id
    self.title = title
    self.systemImage = systemImage
    self.accessibilityIdentifier = accessibilityIdentifier
  }
}
