//
//  W3WColorPickerPopup.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 10/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import W3WSwiftThemes

/// Anchored colour picker: the current colour sits in a cell that hangs off the trailing edge,
/// the other colours fill a grid below it. The caller positions it under the control it
/// belongs to, dismisses it on taps outside, and identifies the current colour by palette
/// index so no colour-equality is needed here.
public struct W3WColorPickerPopup: View {
  @Environment(\.theme) private var theme

  private let colors: [W3WColor]
  private let currentIndex: Int?
  private let columns: Int
  private let accessibilityLabels: [String]
  private let accessibilityIdentifierPrefix: String?
  private let onPick: (W3WColor) -> Void

  private let cell: CGFloat = 36
  private let swatch: CGFloat = 18

  /// - Parameters:
  ///   - currentIndex: index in `colors` of the colour shown in the attached top cell with a
  ///     border and excluded from the grid; nil or out of range shows the plain grid
  ///   - accessibilityLabels: spoken names, index-aligned with `colors` (missing entries get none)
  ///   - accessibilityIdentifierPrefix: when set, the swatch for `colors[N]` gets "<prefix>N" for UI tests
  public init(colors: [W3WColor],
              currentIndex: Int?,
              columns: Int = 3,
              accessibilityLabels: [String] = [],
              accessibilityIdentifierPrefix: String? = nil,
              onPick: @escaping (W3WColor) -> Void) {
    self.colors = colors
    self.currentIndex = currentIndex.flatMap { colors.indices.contains($0) ? $0 : nil }
    self.columns = max(1, columns)
    self.accessibilityLabels = accessibilityLabels
    self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
    self.onPick = onPick
  }

  private struct Entry {
    let index: Int
    let color: W3WColor
  }

  private var currentEntry: Entry? {
    currentIndex.map { Entry(index: $0, color: colors[$0]) }
  }

  /// every palette colour except the current one, keeping palette indices for labels and tags
  private var others: [Entry] {
    colors.enumerated()
      .filter { $0.offset != currentIndex }
      .map { Entry(index: $0.offset, color: $0.element) }
  }

  private var gridRows: [[Entry]] {
    stride(from: 0, to: others.count, by: columns).map { Array(others[$0 ..< min($0 + columns, others.count)]) }
  }

  private func label(for entry: Entry) -> String? {
    accessibilityLabels.indices.contains(entry.index) ? accessibilityLabels[entry.index] : nil
  }

  private func identifier(for entry: Entry) -> String? {
    accessibilityIdentifierPrefix.map { "\($0)\(entry.index)" }
  }

  public var body: some View {
    VStack(alignment: .trailing, spacing: 0) {
      if let currentEntry {
        swatchCell(currentEntry.color, selected: true, accessibilityLabel: label(for: currentEntry), accessibilityIdentifier: identifier(for: currentEntry)) {
          onPick(currentEntry.color)
        }
      }
      ForEach(Array(gridRows.enumerated()), id: \.offset) { _, row in
        HStack(spacing: 0) {
          ForEach(row, id: \.index) { entry in
            swatchCell(entry.color, selected: false, accessibilityLabel: label(for: entry), accessibilityIdentifier: identifier(for: entry)) {
              onPick(entry.color)
            }
          }
        }
      }
    }
    .shadow(color: .black, style: W3WShadow(opacity: 0.04, radius: 1, offsetX: 0, offsetY: 3))
    .shadow(color: .black, style: W3WShadow(opacity: 0.12, radius: 8, offsetX: 0, offsetY: 3))
  }

  private func swatchCell(_ color: W3WColor, selected: Bool, accessibilityLabel: String?, accessibilityIdentifier: String?, action: @escaping () -> Void) -> some View {
    Button(action: action) {
      Rectangle()
        .fill(color.suColor)
        .frame(width: swatch, height: swatch)
        .overlay(Rectangle().strokeBorder(theme.labelsPrimary ?? .primary, lineWidth: selected ? 2 : 0))
        .frame(width: cell, height: cell)
        .w3w(background: \.systemBackgroundBasePrimary)
    }
    .buttonStyle(.plain)
    .accessibilityLabel(optional: accessibilityLabel)
    .accessibilityIdentifier(optional: accessibilityIdentifier)
    .accessibilitySelected(selected)
  }
}

#Preview {
  let colors = [0xE11F26, 0xF6D31F, 0xF4A344, 0xF26C50, 0x3CABAA, 0x5FC98F, 0x98D5E5, 0x2E71B8, 0xCD3B72, 0x8B4CA1]
    .map { W3WColor(all: W3WCoreColor(hex: $0)) }
  return ZStack(alignment: .topTrailing) {
    Color.gray.opacity(0.2)
    W3WColorPickerPopup(colors: colors, currentIndex: 0) { _ in }
      .padding(.top, 40)
      .padding(.trailing, 34)
  }
  .frame(width: 390, height: 300)
}
