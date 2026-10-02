//
//  W3WText.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 20/8/26.
//

import SwiftUI

public struct W3WText: View {
  @Environment(\.translations) private var translations
  private let id: String
  private let arguments: [CVarArg]
  
  public init(_ id: String, _ arguments: CVarArg...) {
    self.id = id
    self.arguments = arguments
  }
  
  public var body: some View {
    Text(
      arguments.isEmpty
      ? translations.get(id: id)
      : translations.get(id: id, arguments)
    )
  }
}
