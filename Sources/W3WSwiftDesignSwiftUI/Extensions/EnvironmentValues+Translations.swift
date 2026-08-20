//
//  EnvironmentValues+Translations.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 1/10/25.
//

import SwiftUI
import W3WSwiftCore

public extension EnvironmentValues {
  /// The translations provider available to SwiftUI views via the environment.
  ///
  /// Defaults to `W3WMockTranslation`, which returns the translation id as-is —
  /// the app is expected to inject a real provider from a parent view:
  /// ```swift
  /// ContentView()
  ///   .environment(\.translations, myTranslations)
  /// ```
  /// Then read it in a view:
  /// ```swift
  /// struct WelcomeView: View {
  ///   @Environment(\.translations) var translations
  ///
  ///   var body: some View {
  ///     VStack {
  ///       Text(translations.get(id: "onboarding.welcome.title"))
  ///       Text(translations.get(id: "onboarding.welcome.greeting", "Hoang"))
  ///     }
  ///   }
  /// }
  /// ```
  /// Alternatively, use `W3WText` to skip reading the environment directly —
  /// it resolves the translation from the environment for you:
  /// ```swift
  /// struct WelcomeView: View {
  ///   var body: some View {
  ///     VStack {
  ///       W3WText("onboarding.welcome.title")
  ///       W3WText("onboarding.welcome.greeting", "Hoang")
  ///     }
  ///   }
  /// }
  /// ```
  @Entry var translations: W3WTranslationsProtocol = W3WMockTranslation()
}
