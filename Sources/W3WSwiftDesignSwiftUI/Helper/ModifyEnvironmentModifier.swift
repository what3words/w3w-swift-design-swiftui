//
//  ModifyEnvironmentModifier.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 29/9/25.
//

import SwiftUI

/// A lightweight ViewModifier that lets you adjust a specific Environment value
/// for the current view subtree.
///
/// How it works:
/// - Reads the current value from the Environment using the provided key path.
/// - Passes a mutable copy into the `modify` closure so you can tweak it.
/// - Re-injects the modified value back into the view hierarchy using `.environment(_:_:))`.
///
/// This is especially useful when you have a composite environment value (e.g. a settings
/// struct) and want to adjust just a few fields locally without redefining a new EnvironmentKey.
///
/// Example:
/// ```swift
/// // Adjust a custom environment value for a specific subtree
/// someView
///   .modifyEnvironment(\.overlayBottomSheetData) { data in
///     data.cornerRadius = 24
///     data.overlayColor = Color.black.opacity(0.5)
///     data.showDragIndicator = false
///   }
/// ```
///
/// Notes:
/// - The change applies only to the modified view and its descendants.
/// - Order of modifiers matters in SwiftUI; place this before views that read the environment.
/// - The closure should be side-effect free; it is evaluated during view updates.
struct ModifyEnvironmentModifier<Value>: ViewModifier {
  /// Captures the current environment for reading the existing value.
  @Environment(\.self) private var environment
  
  /// The key path to the environment value you want to modify.
  let keyPath: WritableKeyPath<EnvironmentValues, Value>
  
  /// A closure that mutates a local copy of the environment value.
  /// The mutated value will be re-applied to the subtree.
  let modify: (inout Value) -> Void
  
  func body(content: Content) -> some View {
    content.environment(keyPath, {
      var value = environment[keyPath: keyPath]
      modify(&value)
      return value
    }())
  }
}

extension View {
  /// Modifies a specific Environment value for this view subtree.
  ///
  /// - Parameters:
  ///   - keyPath: A writable key path to the environment value to change.
  ///   - modify: A closure receiving an inout value to mutate.
  /// - Returns: A view with the adjusted environment value applied to its subtree.
  ///
  /// Example:
  /// ```swift
  /// VStack {
  ///   Content()
  /// }
  /// .modifyEnvironment(\.overlayBottomSheetData) { data in
  ///   data.cornerRadius = 16
  ///   data.overlayColor = Color.black.opacity(0.4)
  /// }
  /// ```
  func modifyEnvironment<Value>(
    _ keyPath: WritableKeyPath<EnvironmentValues, Value>,
    modify: @escaping (inout Value) -> Void
  ) -> some View {
    self.modifier(
      ModifyEnvironmentModifier(
        keyPath: keyPath,
        modify: modify
      )
    )
  }
}
