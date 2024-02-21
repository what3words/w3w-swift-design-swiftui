//
//  File.swift
//  
//
//  Created by Khải Toàn Năng on 20/02/2024.
//

import Foundation

public class W3WActionItemCellViewModel: W3WActionItemCellViewModelProtocol {
  private(set) var scheme: W3WScheme?
  private(set) var iconImage: W3WImage?
  private(set) var uiImage: UIImage?
  private(set) var title: String
  
  init(
    scheme: W3WScheme? = nil,
    iconImage: W3WImage? = nil,
    title: String
  ) {
    self.scheme = scheme
    self.icon = icon
    self.title = title
  }
  
  init(
    scheme: W3WScheme? = nil,
    uiImage: UIImage? = nil,
    title: String
  ) {
    self.scheme = scheme
    self.uiImage = uiImage
    self.title = title
  }
}
