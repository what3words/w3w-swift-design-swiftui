// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "W3WSwiftDesignSwiftUI",
    
    products: [.library(name: "W3WSwiftDesignSwiftUI", targets: ["W3WSwiftDesignSwiftUI"])],

    dependencies: [.package(url: "git@github.com:what3words/w3w-swift-themes.git", branch: "main")],

    targets: [
      .target(name: "W3WSwiftDesignSwiftUI", dependencies: [.product(name: "W3WSwiftThemes", package: "w3w-swift-themes")]),
      .testTarget(name: "w3w-swift-design-swiftuiTests", dependencies: ["W3WSwiftDesignSwiftUI"]),
    ]
)
