//
//  SwiftUIView.swift
//
//
//  Created by Khai Do on 02/02/2024.
//

import SwiftUI
import W3WSwiftThemes

public struct W3WActionItemCell: View {
  var viewModel: W3WActionItemCellViewModelProtocol
  var action: (() -> Void)
  
  public init(
    viewModel: W3WActionItemCellViewModelProtocol,
    action: @escaping () -> Void
  ) {
    self.viewModel = viewModel
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      HStack {
        label
        Spacer()
        arrowImage
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .frame(minHeight: 36)
  }
}

// MARK: - Views

private extension W3WActionItemCell {
  var label: some View {
    HStack(spacing: 16) {
      iconImage
      titleLabel
    }
  }
  
  @ViewBuilder
  var arrowImage: some View {
    W3WNavigationImage()
      .squareFrame(14)
      .foregroundColor(iconColor)
  }
  
  var titleLabel: some View {
    Text(viewModel.title)
      .useFont(labelFont)
      .foregroundColor(labelColor)
  }
  
  @ViewBuilder
  var iconImage: some View {
    if let icon = viewModel.iconImage {
      Image(uiImage: icon.get())
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .squareFrame(20)
        .foregroundColor(iconColor)
    } else if let image = viewModel.uiImage {
      Image(uiImage: image)
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .squareFrame(24)
        .foregroundColor(iconColor)
    } else {
      EmptyView()
    }
  }
}

// MARK: - Getters

private extension W3WActionItemCell {
  private var iconColor: Color? {
    let color = W3WColor(
      light: W3WCoreColor.blue50,
      dark: W3WCoreColor.blue72
    )

    return color.suColor
  }
  
  private var labelColor: Color? {
    let color = W3WColor(
      light: W3WCoreColor.blue20,
      dark: W3WCoreColor.grey95
    )
    
    return color.suColor
  }
  
  private var labelFont: UIFont? {
    return W3WFonts().body.withSize(17)
  }
}

#Preview {
  List {
    Section {
      W3WActionItemCell(
        viewModel: W3WActionItemCellViewModel(
          scheme: W3WTheme(theme: .what3words).schemes[.cells],
          iconImage: W3WImage.camera,
          title: "Testing"),
        action: {
          
        }
      )
      W3WActionItemCell(
        viewModel: W3WActionItemCellViewModel(
          scheme: W3WTheme(theme: .what3words).schemes[.cells],
          iconImage: W3WImage.badgeFill,
          title: "Badge"),
        action: {
          
        }
      )
    }
  }
}
