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
        .package(path: "/Users/krunal.patel/Projects/iOS/swift")
//        .package(url: "https://github.com/abhi-m-simformsolutons/swift.git", revision: "6a1feb79502629ce272ade809f6f5992c43ad9fd"),
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
