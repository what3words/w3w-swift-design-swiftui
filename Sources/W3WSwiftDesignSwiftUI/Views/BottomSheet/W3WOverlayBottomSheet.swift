//
//  W3WOverlayBottomSheet.swift
//  w3w-swift-design-swiftui
//
//  Created by Kaley Nguyen on 18/8/25.
//

import SwiftUI
import W3WSwiftThemes

public struct W3WOverlayBottomSheet<Content: View>: View {
  @Environment(\.overlayBottomSheetData) private var data
  @ViewBuilder private let content: () -> Content
  private let onDismiss: () -> Void
  
  public init(
    @ViewBuilder content: @escaping () -> Content,
    onDismiss: @escaping () -> Void = {}
  ) {
    self.content = content
    self.onDismiss = onDismiss
  }
  
  public var body: some View {
    ZStack(alignment: .bottom) {
      data.overlayColor
        .edgesIgnoringSafeArea(.all)
        .onTap {
          if data.dismissOnTapOutside {
            onDismiss()
          }
        }
      VStack(spacing: 0) {
        if data.showDragIndicator {
          Rectangle()
            .fill(W3WCoreColor(hex: 0x7F7F7F).suColor.opacity(0.4))
            .cornerRadius(4.0)
            .frame(width: 36.0, height: 5.0)
            .padding(.top, W3WPadding.extraMedium.value)
        }
        content()
          .frame(maxWidth: .infinity)
      }
      .background(background)
    }
  }
  
  private var background: some View {
    W3WColor.w3wSystemBackgroundElevatedPrimary.suColor
      .cornerRadius(data.cornerRadius, corners: [.topLeft, .topRight])
      .edgesIgnoringSafeArea(.bottom)
  }
}

@available(iOS 17.0, *)
#Preview {
  @Previewable @State var isPresented = false
  
  Color.blue
    .edgesIgnoringSafeArea(.all)
    .onTapGesture {
      isPresented.toggle()
    }
    .overlayBottomSheet(isPresented: $isPresented) {
      Text("Hello")
    }
    .overlayBottomSheetDismissOnTapOutside(false)
}

#Preview {
  Color.blue
    .edgesIgnoringSafeArea(.all)
    .overlayBottomSheet(isPresented: .constant(true)) {
      Text("Hello")
        .background(Color.blue)
    }
    .hideOverlayBottomSheetDragIndicator()
}
