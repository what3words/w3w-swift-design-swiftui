//
//  W3WMenuList.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 09/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Bottom-sheet menu content: HIG detail rows (56pt, glyph + title) with hairlines inset past
/// the glyph. Host it in an overlay bottom sheet; `onSelect` fires once per tap.
public struct W3WMenuList: View {
  /// rows in display order; hosts can use the count to size a sheet
  public let rows: [W3WMenuRow]
  private let onSelect: (W3WMenuRow) -> Void

  public init(rows: [W3WMenuRow], onSelect: @escaping (W3WMenuRow) -> Void) {
    self.rows = rows
    self.onSelect = onSelect
  }

  public var body: some View {
    VStack(spacing: 0) {
      ForEach(rows) { row in
        Button { onSelect(row) } label: {
          HStack(spacing: 8) {
            Image(systemName: row.systemImage)
              .font(.system(size: 17))
              .frame(width: 30, height: 30)
            Text(row.title)
              .w3w(font: .body)
            Spacer()
          }
          .w3w(foreground: \.labelsTertiary)
          .padding(.leading, 16)
          .padding(.trailing, 16)
          .frame(height: 56)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier(optional: row.accessibilityIdentifier)

        if row.id != rows.last?.id {
          W3WListDivider(leadingInset: 54)
        }
      }
    }
    .w3w(background: \.systemBackgroundElevatedPrimary)
  }
}

#Preview {
  W3WMenuList(rows: [
    W3WMenuRow(id: "export", title: "Export to CSV", systemImage: "doc"),
    W3WMenuRow(id: "rename", title: "Rename", systemImage: "square.and.pencil"),
    W3WMenuRow(id: "delete", title: "Delete list", systemImage: "trash"),
    W3WMenuRow(id: "share", title: "Share list", systemImage: "square.and.arrow.up"),
  ]) { _ in }
}
