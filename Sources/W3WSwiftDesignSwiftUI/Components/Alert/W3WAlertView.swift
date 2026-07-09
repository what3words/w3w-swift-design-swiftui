//
//  W3WAlertView.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 9/7/26.
//


import SwiftUI
import W3WSwiftThemes

public struct W3WAlertView: View {

  private let title: String
  private let message: String
  private let showsSpinner: Bool
  private let buttonTitle: String
  private let onButtonTap: () -> Void

  /// - Parameters:
  ///   - title: bold headline line.
  ///   - message: supporting text under the title.
  ///   - showsSpinner: when true, a loading spinner appears under the message (e.g. "downloading…").
  ///   - buttonTitle: the single action button's title.
  ///   - onButtonTap: called when the button is tapped (caller dismisses).
  public init(title: String,
              message: String,
              showsSpinner: Bool = false,
              buttonTitle: String,
              onButtonTap: @escaping () -> Void) {
    self.title = title
    self.message = message
    self.showsSpinner = showsSpinner
    self.buttonTitle = buttonTitle
    self.onButtonTap = onButtonTap
  }

  // no design token for these — button row height, content vertical inset, scrim opacity
  private let buttonHeight: CGFloat = 44
  private let contentVerticalPadding: CGFloat = 22
  private let scrimOpacity: CGFloat = 0.4

  // card width tracks the screen width (proportional), capped so it doesn't get huge on iPad
  private let cardWidthFraction: CGFloat = 0.72
  private let maxCardWidth: CGFloat = 400

  public var body: some View {
    GeometryReader { geo in
      card
        .frame(width: min(geo.size.width * cardWidthFraction, maxCardWidth))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(W3WColor.w3wBrandBaseSecondary.suColor.opacity(scrimOpacity).edgesIgnoringSafeArea(.all))
    }
    .edgesIgnoringSafeArea(.all)
  }

  private var card: some View {
    VStack(spacing: 0) {
        VStack(spacing: W3WPadding.medium.value) {
          Text(title)
            .w3w(font: .headline)

          Text(message)
            .w3w(font: .footnote)

          if showsSpinner {
            W3WProgressView()
          }
        }
        .w3w(foreground: \.labelsPrimaryBlackInverse)
        .multilineTextAlignment(.center)
        .padding(.vertical, contentVerticalPadding)
        .padding(.horizontal, W3WPadding.bold.value)

        Divider().w3w(background: \.separatorNonOpaque)

        Button(action: onButtonTap) {
          Text(buttonTitle)
            .w3w(font: .body, weight: .bold)
            .w3w(foreground: \.labelsSecondary)
            .frame(maxWidth: .infinity)
            .frame(height: buttonHeight)
        }
      }
      .w3w(background: \.systemBackgroundElevatedPrimary)
      .clipShape(RoundedRectangle(cornerRadius: W3WCornerRadius.large.value))
    }
  }

#Preview {

  W3WAlertView(title: "Language package downloading",
               message: "Please wait for the download to finish before proceeding…",
               showsSpinner: true,
               buttonTitle: "Back",
               onButtonTap: {})
}
