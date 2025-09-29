//
//  W3WProgressView.swift
//  w3w-swift-design-swiftui
//
//  Created by Hoang Ta on 23/9/25.
//

import SwiftUI
import W3WSwiftThemes

public struct W3WProgressView: View {
  public init() {}
  
  public var body: some View {
    if #available(iOS 15.0, *) {
      ProgressView()
        .progressViewStyle(.circular)
        .scaleEffect(1.5)
        .tint(W3WCoreColor.hig.grey52.suColor)
    } else {
      ActivityIndicator()
    }
  }
}

private struct ActivityIndicator: UIViewRepresentable {
  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.startAnimating()
    return indicator
  }
  
  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
