//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 2/7/24.
//

import SwiftUI

public struct W3WSUButton: View {
  var title: String = ""
  var iconImage: W3WImage?
  var uiImage: UIImage?
  var iconSize: CGFloat = 24
  let scheme: W3WScheme?
  var isExpandable: Bool = false
  var hasBackground: Bool = true
  var action: (() -> Void) = {}
  
  public init(
    title: String = "",
    iconImage: W3WImage? = nil,
    uiImage: UIImage? = nil,
    iconSize: CGFloat = 24,
    scheme: W3WScheme? = nil,
    isExpandable: Bool = false,
    hasBackground: Bool = true,
    action: @escaping () -> Void = {}
  ) {
    self.title = title
    self.iconImage = iconImage
    self.uiImage = uiImage
    self.iconSize = iconSize
    self.scheme = scheme
    self.hasBackground = hasBackground
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
      horizontalPadding: scheme?.styles?.padding?.left,
      verticalPadding: scheme?.styles?.padding?.top,
      isExpandable: isExpandable,
      backgroundColor: hasBackground ? scheme?.colors?.background?.current.suColor : .clear,
      forgroundColor: scheme?.colors?.foreground?.current.suColor,
      action: action
    )
  }
}

#Preview {
  ScrollView {
    VStack {
      W3WSUButton(title: "Primary Large", scheme: .buttonPrimaryLarge())
      W3WSUButton(title: "Primary Medium", scheme: .buttonPrimaryMedium())
      W3WSUButton(title: "Primary Small", scheme: .buttonPrimarySmall())
      
      W3WSUButton(title: "Secondary Large", scheme: .buttonSecondaryLarge())
      W3WSUButton(title: "Secondary Medium", scheme: .buttonSecondaryMedium())
      W3WSUButton(title: "Secondary Small", scheme: .buttonSecondarySmall())
      
      W3WSUButton(title: "Tertiary Large", scheme: .buttonTertiaryLarge())
      W3WSUButton(title: "Tertiary Medium", scheme: .buttonTertiaryMedium())
      W3WSUButton(title: "Tertiary Small", scheme: .buttonTertiarySmall())
      
      W3WSUButton(title: "Quinary Large", scheme: .buttonQuinaryLarge())
      W3WSUButton(title: "Quinary Medium", scheme: .buttonQuinaryMedium())
      W3WSUButton(title: "Quinary Small", scheme: .buttonQuinarySmall())
      
      W3WSUButton(title: "Senary Large", scheme: .buttonSenaryLarge())
      W3WSUButton(title: "Senary Medium", scheme: .buttonSenaryMedium())
      W3WSUButton(title: "Senary Small", scheme: .buttonSenarySmall())
      
      W3WSUButton(title: "Septenary Large", scheme: .buttonSeptenaryLarge())
      W3WSUButton(title: "Septenary Medium", scheme: .buttonSeptenaryMedium())
      W3WSUButton(title: "Septenary Small", scheme: .buttonSeptenarySmall())
    }
    .frame(maxWidth: .infinity)
  }
}
