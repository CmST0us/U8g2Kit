// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "U8g2Kit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "U8g2Kit",
            targets: ["U8g2Kit"]),
        .library(
            name: "CU8g2",
            targets: ["CU8g2"]),
        .library(
            name: "CU8g2SDL",
            targets: ["CU8g2SDL"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CmST0us/SwiftSDL2.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "CU8g2",
            cSettings: [
                .define("U8G2_USE_LARGE_FONTS", .when(platforms: [.linux])),
                .unsafeFlags(["-Wno-pointer-sign"])
            ]),

        .target(
            name: "U8g2Kit",
            dependencies: ["CU8g2"]
        ),

        .target(
            name: "CU8g2SDL",
            dependencies: [
                "CU8g2", 
                .product(name: "SDL2", package: "SwiftSDL2")]
        ),

        .executableTarget(
            name: "U8g2SDLSimulator",
            dependencies: [
                "U8g2Kit",
                "CU8g2SDL",
                .product(name: "SDL2", package: "SwiftSDL2")]
        ),
    ]
)
