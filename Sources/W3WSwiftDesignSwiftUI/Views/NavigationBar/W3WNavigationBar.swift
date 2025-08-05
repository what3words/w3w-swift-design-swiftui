//
//  W3WNavigationBar.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 3/7/25.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftThemes

public struct W3WNavigationBar: View {
  
  private let scheme: W3WScheme?

  private var translations: W3WTranslationsProtocol?
  
  private let onBack: () -> Void

  public init(scheme: W3WScheme?, translations: W3WTranslationsProtocol, onBack: @escaping () -> Void) {
    self.scheme = scheme
    self.translations = translations
    self.onBack = onBack
  }
  
  public var body: some View {
    ZStack {
      Button(action: onBack) {
        Image(uiImage: backImage)
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .frame(width: 18, height: 18)
          .foregroundColor(scheme?.colors?.secondary?.current.suColor)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      Text(translations?.get(id: "ocr_results_header") ?? "")
        .foregroundColor(scheme?.colors?.foreground?.current.suColor)
        .font(.headline)
    }
    .padding(.horizontal, 8)
    .frame(maxWidth: .infinity)
    .frame(height: 42)
    .background(
      scheme?.colors?.secondaryBackground?.current.suColor.edgesIgnoringSafeArea(.top)
    )
  }
  
  private var backImage: UIImage {
    switch UIView.appearance().semanticContentAttribute {
    case .forceLeftToRight: W3WImage.chevronLeft.get()
    default: W3WImage.chevronRight.get()
    }
  }
}
