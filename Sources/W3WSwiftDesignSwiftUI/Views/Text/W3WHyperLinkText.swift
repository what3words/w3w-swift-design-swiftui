//
//  W3WHyperLinkText.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 30/10/25.
//

import SwiftUI
import W3WSwiftThemes

/// this component is to display a text with a hyperlink in it
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
    onOpenURL: ((URL?) -> Void)?)
  {
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
    return generate()
  }
  
  func generate() -> some View {
    if #available(iOS 15, *) {
      let attributed = NSMutableAttributedString(string: text)
      
      // Find all occurrences of the hyperlink text and make them clickable + underlined
      let pattern = NSRegularExpression.escapedPattern(for: hyperlinkText)
      if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
        let range = NSRange(location: 0, length: (text as NSString).length)
        regex.enumerateMatches(in: text, options: [], range: range) { match, _, _ in
          guard let matchRange = match?.range else { return }
          attributed.addAttributes([
            .link: url as Any,
            // has underline
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: hyperlinkColor?.uiColor as Any,
            .font: hyperlinkFont?.uiFont as Any
          ], range: matchRange)
        }
      }
      
      // Apply default font/color to the rest of the text
      attributed.addAttributes([
        .font: UIFont.preferredFont(forTextStyle: .body),
      ], range: NSRange(location: 0, length: attributed.length))
      
      // Convert NSAttributedString → AttributedString → SwiftUI Text
      let attrSwiftUI = try! AttributedString(attributed, including: \.uiKit)
      
      return Text(attrSwiftUI)
        .font(font?.suFont)
        .foregroundColor(color?.suColor)
        .environment(\.openURL, OpenURLAction { url in
          onOpenURL?(url)
          return .handled
        })
    } else {
      return Text(text)
        .foregroundColor(color?.suColor)
        .font(font?.suFont)
        .lineLimit(nil)
    }
  }
}
