//
//  SwiftUIView.swift
//
//
//  Created by Khai Do on 25/6/24.
//
//
//import SwiftUI
//
//public struct W3WMapActionPanel: View {
//  var backNavBarTitle: String = ""
//  var shareButtonTitle: String = ""
//  var navigationButtonTitle: String = ""
//  var saveNavigationButtonTitlt: String = ""
//  
//  //var events: W3WEvent<W3WActionPanelEvent>?
//  public init() {}
//  
//  public var body: some View {
//    W3WActionPanel(
//      navigationBar: {
//        navBar
//      }, content: {
//        content
//      }
//    )
//  }
//}
//
//// MARK: - Views
//
//private extension W3WMapActionPanel {
//  var navBar: some View {
//    W3WMapActionPanelNavBar(
//      title: backNavBarTitle,
//      onCloseTap: {},
//      onBackTap: {}
//    )
//  }
//  
//  var content: some View {
//    VStack {
//      buttonStackView
//    }
//  }
//  
//  var addressView: some View {
//    EmptyView()
//  }
//  
//  var savedLocationView: some View {
//    EmptyView()
//  }
//  
//  var buttonStackView: some View {
//    ScrollableHStack {
//      volumnButton
//      shareButton
//      navigationButton
//      saveButton
//    }
//  }
//  
//  var volumnButton: some View {
//    W3WSUButton(
//      iconImage: .speakerWave2Fill,
//      scheme: .buttonPrimaryLarge(),
//      action: {}
//    )
//  }
//  
//  var shareButton: some View {
//    W3WSUButton(
//      title: shareButtonTitle,
//      iconImage: .speakerWave2Fill,
//      scheme: .buttonPrimaryLarge(),
//      action: {}
//    )
//  }
//  
//  var navigationButton: some View {
//    W3WSUButton(
//      title: navigationButtonTitle,
//      iconImage: .speakerWave2Fill,
//      scheme: .buttonPrimaryLarge(),
//      isExpandable: true,
//      action: {}
//    )
//  }
//  
//  var saveButton: some View {
//    W3WSUButton(
//      title: shareButtonTitle,
//      iconImage: .speakerWave2Fill,
//      scheme: .buttonPrimaryLarge(),
//      action: {}
//    )
//  }
//}
//
//#Preview {
//  W3WMapActionPanel()
//}
