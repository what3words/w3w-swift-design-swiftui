//
//  SwiftUIView.swift
//
//
//  Created by Khải Toàn Năng on 02/02/2024.
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
    Label(
      title: { titleLabel },
      icon: { iconImage }
    )
  }
  
  @ViewBuilder
  var arrowImage: some View {
    W3WNavigationImage()
      .squareFrame(18)
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
        .squareFrame(18)
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
    return viewModel.scheme?.colors?.secondary?.suColor
  }
  
  private var labelColor: Color? {
    return viewModel.scheme?.colors?.foreground?.suColor
  }
  
  private var labelFont: UIFont? {
    return viewModel.scheme?.styles?.fonts?.body
  }
}

#Preview {
  W3WActionItemCell(
    viewModel: W3WActionItemCellViewModel(
      iconImage: W3WImage.arrowLeft,
      title: "Testing"),
    action: {
      
    }
  )
}
