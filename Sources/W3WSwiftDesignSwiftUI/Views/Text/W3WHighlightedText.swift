//
//  W3WHighlightedText.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 30/7/25.
//
import SwiftUI
import W3WSwiftThemes

@available(iOS 15, *)
public struct W3WHighlightedText: View {
  let text: String
  let color: Color?
  let font: W3WFont?
  let highlightedText: String?
  let highlightedTextColor: Color?
  let highlightedTextFont: W3WFont?
  
  public init(text: String,
              color: Color? = nil,
              font: W3WFont? = nil,
              highlightedText: String? = nil,
              highlightedTextColor: Color? = nil,
              highlightedTextFont: W3WFont? = nil) {
    self.text = text
    self.color = color
    self.font = font
    self.highlightedText = highlightedText
    self.highlightedTextColor = highlightedTextColor
    self.highlightedTextFont = highlightedTextFont
  }
  
  public var body: some View {
    Text(makeAttributedString())
  }
  
  private func makeAttributedString() -> AttributedString {
    var attributed = AttributedString(text)
    attributed.foregroundColor = color
    attributed.font = font?.suFont
    
    if let highlightedText,
       let range1 = attributed.range(of: highlightedText) {
      attributed[range1].foregroundColor = highlightedTextColor
      attributed[range1].font = highlightedTextFont?.suFont
    }
    
    return attributed
  }
}

#Preview {
  if #available(iOS 15, *) {
    W3WHighlightedText(text: "Hello World", color: .black, highlightedText: "World", highlightedTextColor: .red)
  } else {
    // Fallback on earlier versions
    Text("Hello World")
  }
}
