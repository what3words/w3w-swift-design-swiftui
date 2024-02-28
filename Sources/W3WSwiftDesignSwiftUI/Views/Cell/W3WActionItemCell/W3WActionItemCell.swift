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
  var colorScheme: ColorScheme?
  
  public init(
    viewModel: W3WActionItemCellViewModelProtocol,
    colorScheme: ColorScheme? = nil,
    action: @escaping () -> Void
  ) {
    self.viewModel = viewModel
    self.action = action
    self.colorScheme = colorScheme
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
    if let colorScheme {
      if colorScheme == .dark {
        return W3WCoreColor.blue72.suColor
      }
      
      if colorScheme == .light {
        return W3WCoreColor.blue50.suColor
      }
    }
    return W3WColor.w3wLabelsSecondary.suColor
  }
  
  private var labelColor: Color? {
    if colorScheme == .dark {
      return W3WCoreColor.grey95.suColor
    }
    
    if colorScheme == .light {
      return W3WCoreColor.blue20.suColor
    }
    return W3WColor.w3wLabelsSecondary.suColor
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
          iconImage: W3WImage.arrowLeft,
          title: "Testing"),
        action: {
          
        }
      )
    }
  }
}
