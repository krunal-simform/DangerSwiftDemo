// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "DangerDependencies",
    products: [
        .library(
            name: "DangerDeps",
            type: .dynamic,
            targets: ["DangerDependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "3.18.1"),
    ],
    targets: [
        // This is just an arbitrary Swift file in our app, that has
        // no dependencies outside of Foundation, the dependencies section
        // ensures that the library for Danger gets build also.
        .target(name: "DangerDependencies", dependencies: [
            .product(name: "Danger", package: "swift")
        ], path: "Loader", sources: ["DangerLoader.swift"]),
    ]
)
