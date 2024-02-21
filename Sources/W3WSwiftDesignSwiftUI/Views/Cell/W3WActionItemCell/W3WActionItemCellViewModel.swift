//
//  File.swift
//  
//
//  Created by Khải Toàn Năng on 20/02/2024.
//

import Foundation
import W3WSwiftThemes
import UIKit

public class W3WActionItemCellViewModel: W3WActionItemCellViewModelProtocol {
  private(set) public var scheme: W3WScheme?
  private(set) public var iconImage: W3WImage?
  private(set) public var uiImage: UIImage?
  private(set) public var title: String
  
  public init(
    scheme: W3WScheme? = nil,
    iconImage: W3WImage? = nil,
    title: String
  ) {
    self.scheme = scheme
    self.iconImage = iconImage
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
