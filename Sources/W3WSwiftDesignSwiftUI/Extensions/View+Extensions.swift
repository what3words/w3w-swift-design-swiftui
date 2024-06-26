//
//  File.swift
//  
//
//  Created by Khai Do on 19/02/2024.
//

import SwiftUI

public extension View {
  
  /**
   Make a Square Frame for SwiftUI view
   - parameters:
        - size: width and height of the square Frame
   */
  func squareFrame(_ size: CGFloat) -> some View {
    self.frame(width: size, height: size)
  }
  
  /**
   Add Specific corner radius to specific corner for SwiftUI view
   - parameters:
        - radius: Corner radius
        - corners: Specify the corner to reshapre
   */
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
      clipShape( RoundedCorner(radius: radius, corners: corners) )
  }
}
