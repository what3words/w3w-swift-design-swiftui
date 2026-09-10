//
//  UIViewController+OverlayBottomSheet.swift
//  w3w-swift-design-swiftui
//
//  Created by Au Nguyen on 10/09/2026.
//  Copyright © 2026 What3Words. All rights reserved.
//

import SwiftUI
import UIKit

public extension UIViewController {

  /// Presents SwiftUI content in a `W3WOverlayBottomSheet` over the current screen. The drag
  /// indicator is shown unless the caller hides it; the sheet dismisses itself on outside taps.
  func presentOverlayBottomSheet<Content: View>(cornerRadius: CGFloat = 14,
                                                showsDragIndicator: Bool = true,
                                                dismissOnTapOutside: Bool = true,
                                                animated: Bool = true,
                                                @ViewBuilder content: () -> Content) {
    let inner = content()
    let sheet = W3WOverlayBottomSheet {
      inner
    } onDismiss: { [weak self] in
      self?.dismiss(animated: true)
    }
    .overlayBottomSheetDismissOnTapOutside(dismissOnTapOutside)
    .overlayBottomSheetCornerRadius(cornerRadius)

    let host: UIHostingController<AnyView>
    if showsDragIndicator {
      host = UIHostingController(rootView: AnyView(sheet))
    } else {
      host = UIHostingController(rootView: AnyView(sheet.hideOverlayBottomSheetDragIndicator()))
    }
    // clear background so the presenting screen shows through the overlay without a flicker
    host.view.backgroundColor = .clear
    host.modalPresentationStyle = .overFullScreen
    host.modalTransitionStyle = .crossDissolve
    present(host, animated: animated)
  }
}
