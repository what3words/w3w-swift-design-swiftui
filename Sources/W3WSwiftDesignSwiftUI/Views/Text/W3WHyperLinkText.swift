//
//  W3WHyperLinkText.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 30/10/25.
//

import SwiftUI
import W3WSwiftThemes

/// This component displays a text with a clickable hyperlink inside it.
public struct HyperlinkText: View {
  let text: String
  let color: W3WColor?
  let font: W3WFont?
  let hyperlinkText: String
  let hyperlinkColor: W3WColor?
  let hyperlinkFont: W3WFont?
  let url: URL?
  let onOpenURL: ((URL?) -> Void)?
  
  public init(
    text: String,
    color: W3WColor?,
    font: W3WFont?,
    hyperlinkText: String,
    hyperlinkColor: W3WColor?,
    hyperlinkFont: W3WFont?,
    url: URL?,
    onOpenURL: ((URL?) -> Void)?
  ) {
    self.text = text
    self.color = color
    self.font = font
    self.hyperlinkText = hyperlinkText
    self.hyperlinkColor = hyperlinkColor
    self.hyperlinkFont = hyperlinkFont
    self.url = url
    self.onOpenURL = onOpenURL
  }
  
  public var body: some View {
    if #available(iOS 15, *) {
      let attributed = NSMutableAttributedString(string: text)
      let fullRange = NSRange(location: 0, length: attributed.length)
      
      // Apply font/color to the whole text first
      var baseAttributes: [NSAttributedString.Key: Any] = [:]
      if let uiFont = font?.uiFont {
        baseAttributes[.font] = uiFont
      }
      if let uiColor = color?.uiColor {
        baseAttributes[.foregroundColor] = uiColor
      }
      attributed.addAttributes(baseAttributes, range: fullRange)
      
      // Apply hyperlink style to the matched text
      let nsRange = (text as NSString).range(of: hyperlinkText, options: [])
      if let _ = Range(nsRange, in: text) {
        var matchAttributes: [NSAttributedString.Key: Any] = [:]
        if let url {
          matchAttributes[.link] = url
        }
        if let uiFont = hyperlinkFont?.uiFont {
          matchAttributes[.font] = uiFont
        }
        if let uiColor = hyperlinkColor?.uiColor {
          matchAttributes[.foregroundColor] = uiColor
        }
        matchAttributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        attributed.addAttributes(matchAttributes, range: nsRange)
      }
      
      // Convert NSAttributedString → AttributedString → SwiftUI Text
      let attrSwiftUI = try! AttributedString(attributed, including: \.uiKit)
      
      return Text(attrSwiftUI)
        .environment(\.openURL, OpenURLAction { url in
          onOpenURL?(url)
          return .handled
        })
    } else {
      // Fallback for iOS < 15
      return Text(text)
        .foregroundColor(color?.suColor)
        .font(font?.suFont)
        .lineLimit(nil)
    }
  }
}
