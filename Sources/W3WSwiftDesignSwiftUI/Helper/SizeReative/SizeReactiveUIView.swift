//
//  File.swift
//
//
//  Created by Khải Toàn Năng on 24/6/24.
//

import UIKit
import SwiftUI
import Combine
import W3WSwiftCore

public class SizeReactiveUIView<Content: View>: UIView {
  private var cancellables: Set<AnyCancellable> = []
  
  var isHeightReactive: Bool
  var isWidthReactive: Bool
  
  public var onHeightChanged = W3WEvent<CGFloat>()
  public var onWidthChanged = W3WEvent<CGFloat>()
  
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
    hostingController.view.isOpaque = false
    hostingController.view.backgroundColor = UIColor.clear
    
    if #available(iOS 16.4, *) {
      hostingController.safeAreaRegions = SafeAreaRegions()
    } else {
      hostingController.disableSafeArea()
    }
    
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
    
    onHeightChanged.send(height)
  }
  
  private func updateNewWidth(_ width: CGFloat) {
    if let widthConstraint = self.constraints.first(where: { $0.firstAttribute == .width }) {
      widthConstraint.constant = width
    } else {
      self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    onWidthChanged.send(width)
  }
}

// MARK: - Getters

extension SizeReactiveUIView {
  var currentHeight: CGFloat {
    if let heightConstraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
      return heightConstraint.constant
    }
    
    return 0
  }
  
  var currentWidth: CGFloat {
    if let widthConstraint = self.constraints.first(where: { $0.firstAttribute == .width }) {
      return widthConstraint.constant
    }
    
    return 0
  }
}

extension UIHostingController {
  func disableSafeArea() {
    guard let viewClass = object_getClass(view) else { return }
    
    let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoreSafeArea")
    if let viewSubclass = NSClassFromString(viewSubclassName) {
      object_setClass(view, viewSubclass)
    }
    else {
      guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String else { return }
      guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0) else { return }
      
      if let method = class_getInstanceMethod(UIView.self, #selector(getter: UIView.safeAreaInsets)) {
        let safeAreaInsets: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in
          return .zero
        }
        class_addMethod(viewSubclass, #selector(getter: UIView.safeAreaInsets), imp_implementationWithBlock(safeAreaInsets), method_getTypeEncoding(method))
      }
      
      objc_registerClassPair(viewSubclass)
      object_setClass(view, viewSubclass)
    }
  }
}
