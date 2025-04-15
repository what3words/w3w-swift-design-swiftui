//
//  ReativeSizeWrapperView.swift
//
//
//  Created by Khai Do on 24/6/24.
//

import SwiftUI
import Combine

public protocol DynamicSizeViewProtocol: View {
  var sizePublisher: CurrentValueSubject<CGSize, Never> { get }
}

public struct SizeReactiveWrapperView<Content: View>: DynamicSizeViewProtocol {
  public var sizePublisher: CurrentValueSubject<CGSize, Never>
  
  let content: Content
  
  public init(
    @ViewBuilder content: () -> Content
  ) {
    self.sizePublisher = CurrentValueSubject<CGSize, Never>(CGSize(width: 0, height: 0))
    self.content = content()
  }
  
  public var body: some View {
    content.background(
      GeometryReader { geometry in
        Color.clear
          .onAppear {
            sizePublisher.send(geometry.size)
          }
          .onReceive(Just(geometry.size)) { _ in
            sizePublisher.send(geometry.size)
          }
      }
    )
  }
}

//#Preview {
//  SizeReactiveWrapperView {
//    W3WActionPanel(
//      shouldShowNavBar: true,
//      navBarTitle: "Testing",
//      cornerRadius: 8
//    ) {
//      VStack {
//        Text("Testing")
//        Text("Testing")
//        Text("Testing")
//        Text("Testing")
//        Text("Testing")
//        Text("Testing")
//      }
//      .frame(maxWidth: .infinity)
//      .background(Color.green)
//    }
//  }
//}
