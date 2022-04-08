// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "artist-hub-core",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ArtistHubCore",
            targets: [
                "ArtistHubCore"
            ]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.5.3")
    ],
    targets: [
        .target(
            name: "ArtistHubCore",
            dependencies: [
                .product(name: "CombineSchedulers", package: "combine-schedulers")
            ]),
        .testTarget(
            name: "ArtistHubCoreTests",
            dependencies: [
                "ArtistHubCore"
            ]),
    ]
)
