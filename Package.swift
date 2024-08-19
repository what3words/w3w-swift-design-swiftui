// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "w3w-swift-design-swiftui",
    platforms: [.iOS("14.0")],
    products: [.library(name: "W3WSwiftDesignSwiftUI", targets: ["W3WSwiftDesignSwiftUI"])],

    dependencies: [.package(url: "git@github.com:what3words/w3w-swift-themes.git", "1.0.0"..<"2.0.0")],

    targets: [
      .target(name: "W3WSwiftDesignSwiftUI", dependencies: [.product(name: "W3WSwiftThemes", package: "w3w-swift-themes")]),
      .testTarget(name: "w3w-swift-design-swiftuiTests", dependencies: ["W3WSwiftDesignSwiftUI"]),
    ]
)
