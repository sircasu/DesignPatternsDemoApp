// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FakeStoreListDetail",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FakeStoreListDetail",
            targets: ["FakeStoreListDetail"]),  
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FakeStoreListDetail",
            dependencies: ["Alamofire"]
        ),
    ]
)
