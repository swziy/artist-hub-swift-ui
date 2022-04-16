// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "artist-hub-ui",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ArtistHubUI",
            targets: ["ArtistHubUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ArtistHubUI",
            dependencies: [],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "ArtistHubUITests",
            dependencies: ["ArtistHubUI"]),
    ]
)
