//
//  File.swift
//
//
//  Created by Khải Toàn Năng on 24/6/24.
//

import UIKit
import SwiftUI
import Combine

public class SizeReactiveUIView<Content: View>: UIView {
  private var cancellables: Set<AnyCancellable> = []
  
  var isHeightReactive: Bool
  var isWidthReactive: Bool
  
  public init(
    isHeightReactive: Bool = false,
    isWidthReactive: Bool = false,
    rootView: Content
  ) {
    self.isHeightReactive = isHeightReactive
    self.isWidthReactive = isWidthReactive
    
    super.init(frame: .zero)
    setupView(rootView: rootView)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView(rootView: Content) {
    let reactiveView = SizeReactiveWrapperView {
      rootView
    }
    let hostingController = UIHostingController(rootView: reactiveView)
    
    addSubview(hostingController.view)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
    
    reactiveView.sizePublisher
      .sink { [weak self] newSize in
        guard let self = self else { return }
        if isHeightReactive {
          updateNewHeight(newSize.height)
        }
        
        if isWidthReactive {
          updateNewWidth(newSize.width)
        }
      }
      .store(in: &cancellables)
  }
  
  private func updateNewHeight(_ height: CGFloat) {
    if let heightConstraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
      heightConstraint.constant = height
    } else {
      self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  private func updateNewWidth(_ width: CGFloat) {
    if let widthConstraint = self.constraints.first(where: { $0.firstAttribute == .width }) {
      widthConstraint.constant = width
    } else {
      self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
  }
}
