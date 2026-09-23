//
//  W3WHostingController.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 19/8/26.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes

/// A `UIHostingController` that injects the app-wide SwiftUI environment
/// (`colorMode`, `theme`, `layoutDirection`, `translations`) into its root view,
/// keeping them in sync with the given publishers.
public final class W3WHostingController<T: View>: UIHostingController<W3WHostingView<T>> {
  /// Holds the latest environment values, shared with the root `HostingView`.
  private let viewModel = W3WHostingViewModel()

  /// Creates a hosting controller whose SwiftUI environment follows the given publishers.
  ///
  /// All publishers must emit on the main thread. Values are applied synchronously, so a
  /// publisher that replays its current value on subscription (e.g. `CurrentValueSubject`)
  /// is reflected in the very first rendered frame. Each publisher defaults to `Empty()`,
  /// which never emits and leaves the corresponding environment value untouched.
  /// - Parameters:
  ///   - rootView: The SwiftUI view to host.
  ///   - colorMode: Emits the color mode to apply, or `nil` to follow the system appearance.
  ///   - theme: Emits the theme to apply, or `nil` to keep the environment default.
  ///   - layoutDirection: Emits the layout direction to apply, or `nil` to follow the system.
  ///   - translations: Emits the translations provider, or `nil` to keep the environment default.
  public init(
    rootView: T,
    colorMode: some Publisher<W3WColorMode?, Never> = Empty(),
    theme: some Publisher<W3WTheme?, Never> = Empty(),
    layoutDirection: some Publisher<LayoutDirection?, Never> = Empty(),
    translations: some Publisher<W3WTranslationsProtocol?, Never> = Empty()
  ) {
    super.init(rootView: W3WHostingView(viewModel: self.viewModel, content: rootView))
    colorMode.assign(to: &viewModel.$colorMode)
    theme.map { $0.map(W3WSwiftUITheme.init) }.assign(to: &viewModel.$theme)
    layoutDirection.assign(to: &viewModel.$layoutDirection)
    translations.assign(to: &viewModel.$translations)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

/// Bridges the controller's publishers into observable state for `HostingView`.
private final class W3WHostingViewModel: ObservableObject {
  /// Explicit color mode, or `nil` to follow the system appearance.
  @Published var colorMode: W3WColorMode?

  /// Explicit theme, or `nil` to keep the environment default.
  @Published var theme: W3WSwiftUITheme?
  
  /// Explicit layout direction, or `nil` to follow the system.
  @Published var layoutDirection: LayoutDirection?

  /// Explicit translations provider, or `nil` to keep the environment default.
  @Published var translations: W3WTranslationsProtocol?
}

/// Wraps the hosted content and applies the app-wide environment values to it.
public struct W3WHostingView<Content: View>: View {
  /// The system appearance, used when no explicit color mode is set.
  @Environment(\.colorScheme) private var colorScheme
  
  /// The theme inherited from the environment, used when none is published.
  @Environment(\.theme) private var defaultTheme
  
  /// The translations provider inherited from the environment, used when none is published.
  @Environment(\.translations) private var defaultTranslations
  
  /// The layout direction inherited from the system, used when no app language is chosen.
  @Environment(\.layoutDirection) private var systemLayoutDirection
  
  // Workaround to trigger UI updates when dynamicTypeSize changes
  @Environment(\.dynamicTypeSize) private var size

  /// State shared with the owning `W3WHostingController`, which feeds it from publishers.
  @ObservedObject fileprivate var viewModel: W3WHostingViewModel
  
  /// The hosted SwiftUI view.
  let content: Content

  public var body: some View {
    content
      .environment(\.colorMode, colorMode)
      .environment(\.theme, viewModel.theme ?? defaultTheme)
      .environment(\.layoutDirection, viewModel.layoutDirection ?? systemLayoutDirection)
      .environment(\.translations, viewModel.translations ?? defaultTranslations)
  }

  /// The explicit color mode if set, otherwise derived from the system appearance.
  private var colorMode: W3WColorMode {
    if let colorMode = viewModel.colorMode { return colorMode }
    return colorScheme == .dark ? .dark : .light
  }
}

@available(iOS 17.0, *)
#Preview {
  struct Content: View {
    @Environment(\.colorMode) private var colorMode
    
    var body: some View {
      W3WText("Hi")
        .w3w(foreground: \.labelsPrimary)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .w3w(background: \.fillsPrimary)
        .ignoresSafeArea()
        .preferredColorScheme(colorMode == .dark ? .dark : .light)
    }
  }
  
  struct MockTranslation: W3WTranslationsProtocol {
    let value: String
    func get(id: String, language: W3WLanguage?) -> String { value }
    func get(id: String) -> String { value }
  }
  
  @Previewable @State var colorMode = W3WLive<W3WColorMode?>(nil)
  @Previewable @State var theme = W3WLive<W3WTheme?>(nil)
  @Previewable @State var layoutDirection = W3WLive<LayoutDirection?>(nil)
  @Previewable @State var translations = W3WLive<W3WTranslationsProtocol?>(nil)
  
  let content = Content()
    .task {
      while !Task.isCancelled {
        try? await Task.sleep(for: .seconds(1))
        colorMode.send(Bool.random() ? .dark : .light)
        theme.send([W3WTheme.defaults, .standard, .what3words].randomElement() ?? .what3words)
        layoutDirection.send(Bool.random() ? .rightToLeft : .leftToRight)
        let text = String(Int.random(in: 1000...10000))
        translations.send(MockTranslation(value: text))
      }
    }
  
  return W3WHostingController(
    rootView: content,
    colorMode: colorMode,
    theme: theme,
    layoutDirection: layoutDirection,
    translations: translations
  )
}
