// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWCaptchaView",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWCaptchaView", targets: ["WWCaptchaView"]),
    ],
    targets: [
        .target(name: "WWCaptchaView"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
