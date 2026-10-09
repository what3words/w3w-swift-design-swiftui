import Testing
import SwiftUI
import W3WSwiftThemes
@testable import W3WSwiftDesignSwiftUI

struct W3WNavigationControlTests {

  @Test func backChevronFollowsLayoutDirection() {
    #expect(W3WNavigationControl.back.image(for: .leftToRight).get().pngData() == W3WImage.chevronLeft.get().pngData())
    #expect(W3WNavigationControl.back.image(for: .rightToLeft).get().pngData() == W3WImage.chevronRight.get().pngData())
  }

  @Test func closeGlyphIsTheSharedXmark() {
    #expect(W3WNavigationControl.close.image(for: .rightToLeft).get().pngData() == W3WImage.xmark.get().pngData())
  }

  @Test func identifiersMatchTheUIKitLibraryAndExistingUITests() {
    #expect(W3WNavigationControl.back.accessibilityIdentifier == "navigation_bar_back")
    #expect(W3WNavigationControl.close.accessibilityIdentifier == "navigation_bar_close")
    #expect(W3WNavigationControl.close.defaultAccessibilityLabel == "Close")
    #expect(W3WNavigationControl.back.defaultAccessibilityLabel == "Back")
  }

  @Test func tintComesFromTheThemeLabelsTertiary() {
    let theme = W3WSwiftUITheme(theme: .what3words)
    #expect(W3WNavigationControl.tint(from: theme) == W3WTheme.what3words.labelsTertiary?.suColor)
  }
}
