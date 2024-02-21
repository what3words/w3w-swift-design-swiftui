//
//  File.swift
//  
//
//  Created by Khải Toàn Năng on 20/02/2024.
//

import Foundation

class W3WActionItemCellViewModel: W3WActionItemCellViewModelProtocol {
  private(set) var scheme: W3WScheme?
  private(set) var icon: W3WImage?
  private(set) var title: String
  
  init(
    scheme: W3WScheme? = nil,
    icon: W3WImage? = nil,
    title: String
  ) {
    self.scheme = scheme
    self.icon = icon
    self.title = title
  }
}
