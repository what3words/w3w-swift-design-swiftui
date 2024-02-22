//
//  File.swift
//  
//
//  Created by Khải Toàn Năng on 20/02/2024.
//

import Foundation
import W3WSwiftThemes
import UIKit

public protocol W3WActionItemCellViewModelProtocol {
  var scheme: W3WScheme? { get }
  var iconImage: W3WImage? { get }
  var uiImage: UIImage? { get }
  var title: String { get }
}
