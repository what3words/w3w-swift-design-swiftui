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
  
  init(
    viewModel: W3WActionItemCellViewModelProtocol,
    action: @escaping () -> Void
  ) {
    self.viewModel = viewModel
    self.action = action
  }
  
  var body: some View {
    Button(action: action) {
      HStack {
        label
        Spacer()
        arrowImage
      }
    }
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
  
  var arrowImage: some View {
    Image(uiImage: W3WImage.chevronRight.get())
      .resizable()
      .renderingMode(.template)
      .scaledToFit()
      .squareFrame(24)
      .foregroundColor(viewModel.scheme?.colors?.secondary?.suColor)
  }
  
  var titleLabel: some View {
    Text(viewModel.title)
      .useFont(viewModel.scheme?.styles?.fonts?.body.withSize(17))
      .foregroundColor(viewModel.scheme?.colors?.secondary?.suColor)
  }
  
  @ViewBuilder
  var iconImage: some View {
    if let icon = viewModel.icon {
      Image(uiImage: icon.get())
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .squareFrame(24)
        .foregroundColor(viewModel.scheme?.colors?.secondary?.suColor)
    } else if let image = viewModel.uiImage {
      Image(uiImage: image)
        .resizable()
        .renderingMode(.template)
        .scaledToFit()
        .squareFrame(24)
        .foregroundColor(viewModel.scheme?.colors?.secondary?.suColor)
    } else {
      EmptyView()
    }
  }
}

#Preview {
  W3WActionItemCell(
    viewModel: W3WActionItemCellViewModel(
      icon: W3WImage.arrowLeft,
      title: "Testing"),
    action: {
      
    }
  )
}
