//
//  W3WOverlayBottomSheet.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 18/8/25.
//

import SwiftUI
import W3WSwiftThemes

/// Convenience modifiers to present an overlay-style Bottom Sheet.
///
/// Provides two presentation APIs:
/// - Boolean binding (`isPresented`)
/// - Optional item binding (`item`), presented when the binding is non-nil
///
/// Also includes configuration helpers (via Environment):
/// - Hide/show the drag indicator
/// - Corner radius for the sheet
/// - Overlay color (the dimmed background behind the sheet)
///
/// Example using `isPresented`:
/// ```swift
/// struct ContentView: View {
///   @State private var isPresented = false
///
///   var body: some View {
///     Button("Open Bottom Sheet") { isPresented = true }
///       .overlayBottomSheet(isPresented: $isPresented) {
///         VStack {
///           Text("Sheet content")
///           Button("Close") { isPresented = false }
///         }
///         .padding()
///       }
///       .overlayBottomSheetCornerRadius(16)
///       .overlayBottomSheetColor(Color.black.opacity(0.4))
///       .hideOverlayBottomSheetDragIndicator()
///   }
/// }
/// ```
///
/// Example using `item`:
/// ```swift
/// struct ContentView: View {
///   struct Row: Identifiable { let id = UUID(); let title: String }
///   @State private var selected: Row?
///
///   var body: some View {
///     List {
///       Button("Select A") { selected = Row(title: "A") }
///       Button("Select B") { selected = Row(title: "B") }
///     }
///     .overlayBottomSheet(item: $selected) { row in
///       Text("Selected: \(row.title)")
///         .padding()
///     }
///   }
/// }
/// ```
extension View {
  /// Presents an overlay Bottom Sheet controlled by a Boolean binding.
  ///
  /// - Parameters:
  ///   - isPresented: A binding controlling presentation. Set to `true` to present, `false` to dismiss.
  ///   - content: The Bottom Sheet content.
  /// - Returns: A view with the modifier applied.
  func overlayBottomSheet<Content: View>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    modifier(OverlayBottomSheetIsPresentedModifier(isPresented: isPresented, bottomSheet: content))
  }
  
  /// Presents an overlay Bottom Sheet controlled by an optional item binding.
  ///
  /// The sheet appears when `item` is non-nil and passes the unwrapped value to `content`.
  /// On dismiss, `item` will be set to `nil`.
  ///
  /// - Parameters:
  ///   - item: An optional binding that drives presentation. Non-nil to present, `nil` to dismiss.
  ///   - content: The Bottom Sheet content builder that receives the unwrapped item.
  /// - Returns: A view with the modifier applied.
  func overlayBottomSheet<Item, Content: View>(
    item: Binding<Item?>,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View {
    modifier(OverlayBottomSheetItemModifier(item: item, bottomSheet: content))
  }
}

extension View {
  /// Sets whether tapping outside the sheet dismisses it.
  ///
  /// - Returns: A view with the modifier applied.
  /// - SeeAlso: `W3WOverlayBottomSheetData.showDragIndicator`
  func overlayBottomSheetDismissOnTapOutside(_ flag: Bool) -> some View {
    modifyEnvironment(\.overlayBottomSheetData) { data in
      data.dismissOnTapOutside = flag
    }
  }
  
  /// Hides the drag indicator (the small handle) at the top of the Bottom Sheet.
  ///
  /// - Returns: A view with the modifier applied.
  /// - SeeAlso: `W3WOverlayBottomSheetData.showDragIndicator`
  func hideOverlayBottomSheetDragIndicator() -> some View {
    modifyEnvironment(\.overlayBottomSheetData) { data in
      data.showDragIndicator = false
    }
  }
  
  /// Sets the corner radius for the top corners of the Bottom Sheet.
  ///
  /// - Parameter value: The corner radius value.
  /// - Returns: A view with the modifier applied.
  /// - SeeAlso: `W3WOverlayBottomSheetData.cornerRadius`
  func overlayBottomSheetCornerRadius(_ value: CGFloat) -> some View {
    modifyEnvironment(\.overlayBottomSheetData) { data in
      data.cornerRadius = value
    }
  }
  
  /// Sets the overlay color (the dimmed background behind the Bottom Sheet).
  ///
  /// - Parameter value: The overlay color (e.g. `Color.black.opacity(0.4)`).
  /// - Returns: A view with the modifier applied.
  /// - SeeAlso: `W3WOverlayBottomSheetData.overlayColor`
  func overlayBottomSheetColor(_ value: Color) -> some View {
    modifyEnvironment(\.overlayBottomSheetData) { data in
      data.overlayColor = value
    }
  }
}

/// Internal ViewModifier that presents the Bottom Sheet based on `isPresented`.
///
/// Inserts `W3WOverlayBottomSheet` into a ZStack when `isPresented == true`.
/// Dismissing the sheet sets `isPresented = false`.
private struct OverlayBottomSheetIsPresentedModifier<Sheet: View>: ViewModifier {
  @Binding var isPresented: Bool
  let bottomSheet: () -> Sheet
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if isPresented {
        W3WOverlayBottomSheet(content: bottomSheet) {
          isPresented = false
        }
      }
    }
    .animation(.easeInOut, value: isPresented)
  }
}

/// Internal ViewModifier that presents the Bottom Sheet based on an optional `item`.
///
/// Inserts `W3WOverlayBottomSheet` into a ZStack when `item != nil`.
/// Dismissing the sheet sets `item = nil`.
private struct OverlayBottomSheetItemModifier<Item, Sheet: View>: ViewModifier {
  @Binding var item: Item?
  let bottomSheet: (Item) -> Sheet
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if let item {
        W3WOverlayBottomSheet(content: { bottomSheet(item) }) {
          self.item = nil
        }
      }
    }
    .animation(.easeInOut, value: item != nil)
  }
}
