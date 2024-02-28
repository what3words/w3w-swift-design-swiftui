//
//  BlurView.swift
//  
//
//  Created by Thy Nguyen on 28/02/2024.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
  let visualEffect: W3WVisualEffect
  
  init(visualEffect: W3WVisualEffect) {
    self.visualEffect = visualEffect
  }
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    let blurEffectStyle = effectToBlur(effect: visualEffect.style)
    let vibrancyEffectStyle = effectToVibrancy(effect: visualEffect.fill)
    
    let blurEffect = UIBlurEffect(style: blurEffectStyle)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    blurEffectView.isUserInteractionEnabled = false
    blurEffectView.layer.cornerRadius = visualEffect.cornerRadius.value
    blurEffectView.clipsToBounds = true
    
    // Create a vibrant effect view and add to the blur view
    let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyEffectStyle)
    let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
    vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = false
    vibrancyEffectView.clipsToBounds = true
    blurEffectView.contentView.addSubview(vibrancyEffectView)
    NSLayoutConstraint.activate([
      vibrancyEffectView.topAnchor.constraint(equalTo: blurEffectView.contentView.topAnchor),
      vibrancyEffectView.bottomAnchor.constraint(equalTo: blurEffectView.contentView.bottomAnchor),
      vibrancyEffectView.leadingAnchor.constraint(equalTo: blurEffectView.contentView.leadingAnchor),
      vibrancyEffectView.trailingAnchor.constraint(equalTo: blurEffectView.contentView.trailingAnchor),
    ])
    
    return blurEffectView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {}
  
  func effectToBlur(effect: W3WVisualEffectBlur) -> UIBlurEffect.Style {
    switch effect {
      case .regular:
        return .regular
      case .thick:
        return .dark
      case .thin:
        return .light
      case .ultraThick:
        return .dark
      case .ultraThin:
        return .extraLight
    }
  }
  
  @available(iOS 13, *)
  func effectToVibrancy(effect: W3WVisualEffectFill) -> UIVibrancyEffectStyle {
    switch effect {
      case .label:
        return .label
      case .secondaryLabel:
        return .secondaryLabel
      case .tertiaryLabel:
        return .tertiaryLabel
      case .quaternaryLabel:
        return .quaternaryLabel
      case .fill:
        return .fill
      case .secondaryFill:
        return .secondaryFill
      case .tertiaryFill:
        return .tertiaryFill
      case .separator:
        return .separator
    }
  }
}
