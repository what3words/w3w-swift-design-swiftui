//
//  SwiftUIView.swift
//
//
//  Created by Khai Do on 2/7/24.
//

import SwiftUI

public struct W3WSUButton: View {
  var title: String = ""
  var iconImage: W3WImage?
  var uiImage: UIImage?
  var iconSize: CGFloat = 24
  let scheme: W3WScheme?
  var isCapsuleBackground: Bool = false
  var isExpandable: Bool = false
  var hasBackground: Bool = true
  var action: (() -> Void) = {}
  var contentSpacing: CGFloat = 0
  
  public init(
    title: String = "",
    iconImage: W3WImage? = nil,
    uiImage: UIImage? = nil,
    iconSize: CGFloat = 24,
    contentSpacing: CGFloat = 0,
    scheme: W3WScheme? = nil,
    isCapsuleBackground: Bool = false,
    isExpandable: Bool = false,
    hasBackground: Bool = true,
    action: @escaping () -> Void = {}
  ) {
    self.title = title
    self.iconImage = iconImage
    self.uiImage = uiImage
    self.iconSize = iconSize
    self.contentSpacing = contentSpacing
    self.scheme = scheme
    self.hasBackground = hasBackground
    self.isCapsuleBackground = isCapsuleBackground
    self.isExpandable = isExpandable
    self.action = action
  }
  
  public var body: some View {
    W3WBaseButton(
      title: title,
      scheme: scheme ?? .standard,
      iconImage: iconImage,
      uiImage: uiImage,
      iconSize: iconSize,
      contentSpacing: contentSpacing,
      horizontalPadding: scheme?.styles?.padding?.left ?? 0,
      verticalPadding: scheme?.styles?.padding?.top ?? 0,
      cornerRadius: scheme?.styles?.cornerRadius?.value ?? 0.0,
      isCapsuleBackground: isCapsuleBackground,
      isExpandable: isExpandable,
      backgroundColor: hasBackground ? scheme?.colors?.background?.current.suColor : .clear,
      forgroundColor: scheme?.colors?.foreground?.current.suColor,
      action: action
    )
  }
}

#Preview {
  let firstTheme = W3WTheme.standard
  let secondTheme = W3WTheme.what3words
  
  return ScrollView {
    HStack {
      VStack {
        Text("First Theme")
        W3WSUButton(title: "Primary Large", scheme: .buttonPrimaryLarge(theme: firstTheme))
        W3WSUButton(title: "Primary Medium", scheme: .buttonPrimaryMedium(theme: firstTheme))
        W3WSUButton(title: "Primary Small", scheme: .buttonPrimarySmall(theme: firstTheme))
        
        W3WSUButton(title: "Secondary Large", scheme: .buttonSecondaryLarge(theme: firstTheme))
        W3WSUButton(title: "Secondary Medium", scheme: .buttonSecondaryMedium(theme: firstTheme))
        W3WSUButton(title: "Secondary Small", scheme: .buttonSecondarySmall(theme: firstTheme))
        
        W3WSUButton(title: "Tertiary Large", scheme: .buttonTertiaryLarge(theme: firstTheme))
        W3WSUButton(title: "Tertiary Medium", scheme: .buttonTertiaryMedium(theme: firstTheme))
        W3WSUButton(title: "Tertiary Small", scheme: .buttonTertiarySmall(theme: firstTheme))
        
        W3WSUButton(title: "Quinary Large", scheme: .buttonQuinaryLarge(theme: firstTheme))
        W3WSUButton(title: "Quinary Medium", scheme: .buttonQuinaryMedium(theme: firstTheme))
        W3WSUButton(title: "Quinary Small", scheme: .buttonQuinarySmall(theme: firstTheme))
        
        W3WSUButton(title: "Senary Large", scheme: .buttonSenaryLarge(theme: firstTheme))
        W3WSUButton(title: "Senary Medium", scheme: .buttonSenaryMedium(theme: firstTheme))
        W3WSUButton(title: "Senary Small", scheme: .buttonSenarySmall(theme: firstTheme))
        
        W3WSUButton(title: "Septenary Large", scheme: .buttonSeptenaryLarge(theme: firstTheme))
        W3WSUButton(title: "Septenary Medium", scheme: .buttonSeptenaryMedium(theme: firstTheme))
        W3WSUButton(title: "Septenary Small", scheme: .buttonSeptenarySmall(theme: firstTheme))
      }
      
      VStack {
        Text("Second Theme")
        W3WSUButton(title: "Primary Large", scheme: .buttonPrimaryLarge(theme: secondTheme))
        W3WSUButton(title: "Primary Medium", scheme: .buttonPrimaryMedium(theme: secondTheme))
        W3WSUButton(title: "Primary Small", scheme: .buttonPrimarySmall(theme: secondTheme))
        
        W3WSUButton(title: "Secondary Large", scheme: .buttonSecondaryLarge(theme: secondTheme))
        W3WSUButton(title: "Secondary Medium", scheme: .buttonSecondaryMedium(theme: secondTheme))
        W3WSUButton(title: "Secondary Small", scheme: .buttonSecondarySmall(theme: secondTheme))
        
        W3WSUButton(title: "Tertiary Large", scheme: .buttonTertiaryLarge(theme: secondTheme))
        W3WSUButton(title: "Tertiary Medium", scheme: .buttonTertiaryMedium(theme: secondTheme))
        W3WSUButton(title: "Tertiary Small", scheme: .buttonTertiarySmall(theme: secondTheme))
        
        W3WSUButton(title: "Quinary Large", scheme: .buttonQuinaryLarge(theme: secondTheme))
        W3WSUButton(title: "Quinary Medium", scheme: .buttonQuinaryMedium(theme: secondTheme))
        W3WSUButton(title: "Quinary Small", scheme: .buttonQuinarySmall(theme: secondTheme))
        
        W3WSUButton(title: "Senary Large", scheme: .buttonSenaryLarge(theme: secondTheme))
        W3WSUButton(title: "Senary Medium", scheme: .buttonSenaryMedium(theme: secondTheme))
        W3WSUButton(title: "Senary Small", scheme: .buttonSenarySmall(theme: secondTheme))
        
        W3WSUButton(title: "Septenary Large", scheme: .buttonSeptenaryLarge(theme: secondTheme))
        W3WSUButton(title: "Septenary Medium", scheme: .buttonSeptenaryMedium(theme: secondTheme))
        W3WSUButton(title: "Septenary Small", scheme: .buttonSeptenarySmall(theme: secondTheme))
      }
    }
    .frame(maxWidth: .infinity)
  }
  .background(Color.green)
}
