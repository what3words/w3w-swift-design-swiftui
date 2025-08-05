//
//  View+SizeReading.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 2/7/25.
//

import SwiftUI

public extension View {
  /// Tracks the absolute frame (`CGRect`) of the current view in the global coordinate space,
  /// and calls the provided closure whenever that frame changes.
  ///
  /// Useful for observing dynamic layout changes, animations, or responding to geometry updates.
  ///
  /// - Parameter perform: A closure that receives the updated `CGRect` of the view in the global space.
  /// - Returns: A view that tracks and reports its frame changes.
  func onRectChange(_ perform: @escaping (CGRect) -> Void) -> some View {
    background(
      GeometryReader { geometry in
        Color.clear
          .preference(key: RectPreferenceKey.self, value: geometry.frame(in: .global))
      }
    )
    .onPreferenceChange(RectPreferenceKey.self) { value in
      perform(value)
    }
  }
}

private struct RectPreferenceKey: PreferenceKey {
  static var defaultValue: CGRect { .zero }
  
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}
