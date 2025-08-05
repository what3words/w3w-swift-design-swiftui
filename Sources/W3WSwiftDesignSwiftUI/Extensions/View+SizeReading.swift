//
//  View+SizeReading.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 2/7/25.
//

import SwiftUI

/// A view extension that enables detection of dynamic size changes for any SwiftUI view.
///
/// This is useful when you need to observe the size (especially height)
/// of a view that depends on its content, layout, or conditional modifiers,
/// such as inside `VStack`, `GeometryReader`, or dynamic view hierarchies.
///
/// This version supports **tracking multiple views** using a hashable `item` identifier.
///
/// - Parameters:
///   - perform: Closure called with the detected `CGSize` whenever the view's size changes.
///   - item: A `Hashable` key used to distinguish multiple size observations.
///
/// ### Use Cases:
/// - Tracking size of subviews independently (e.g. image, bottom bar, scrollable content).
/// - Adjusting parent layout or padding based on children size.
/// - Supporting animations or transitions that depend on real view sizes.
///
/// ```swift
/// enum Height { case image, content, bottom }
/// ```
///
/// ```swift
/// Image("example")
///   .resizable()
///   .onHeightChange($imageHeight, for: Height.image)
/// ```
public extension View {
  
  /// Tracks the full size of the current view and reports it when it changes.
  func onSizeChange<Value: Hashable>(
    _ perform: @escaping (CGSize) -> Void,
    for item: Value
  ) -> some View {
    background(
      GeometryReader { geometry in
        Color.clear
          .preference(key: SizePreferenceKey<Value>.self, value: [item: geometry.size])
      }
    )
    .onPreferenceChange(SizePreferenceKey<Value>.self) { value in
      if let size = value[item] {
        perform(size)
      }
    }
  }
  
  /// A convenience method that tracks only the height of the current view.
  func onHeightChange<Value: Hashable>(_ height: Binding<CGFloat>, for item: Value) -> some View {
    onSizeChange({ size in
      height.wrappedValue = size.height
    }, for: item)
  }
}

private struct SizePreferenceKey<Item: Hashable>: PreferenceKey {
  typealias Value = [Item: CGSize]
  static var defaultValue: Value { [:] }
  
  static func reduce(value: inout Value, nextValue: () -> Value) {
    for (k, v) in nextValue() {
      value[k] = v
    }
  }
}
