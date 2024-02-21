//
//  File.swift
//  
//
//  Created by Khải Toàn Năng on 20/02/2024.
//

import Foundation

public protocol W3WActionItemCellViewModelProtocol {
  var scheme: W3WScheme? { get }
  var icon: W3WImage? { get }
  var uiImage: UIImage? { get }
  var title: String { get }
}
