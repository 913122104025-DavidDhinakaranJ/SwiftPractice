// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieTicketBookingApplication",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        .package(path: "../AuthLib"),
        .package(url: "https://github.com/stephencelis/SQLite.swift", .upToNextMajor(from: "0.15.5"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "MovieTicketBookingApplication",
            dependencies: [
                "Views",
                "Controllers",
            ]
        ),
        .target(
            name: "Contexts",
            dependencies: [
                "Models",
                "Repositories",
                "Utils",
            ]
        ),
        .target(
            name: "Controllers",
            dependencies: [
                "Models",
                "Errors",
                "Repositories"
            ]
        ),
        .target(name: "Errors"),
        .target(
            name: "Models",
            dependencies: [
                "Errors",
                .product(name: "AuthLib", package: "AuthLib")
            ]
        ),
        .target(
            name: "Repositories",
            dependencies: [
                "Models",
                "Errors",
                .product(name: "AuthLib", package: "AuthLib"),
                .product(name: "SQLite", package: "SQLite.swift")
            ]
        ),
        .target(
            name: "Utils",
            dependencies: [
                "Models",
                "Repositories",
            ]
        ),
        .target(
            name: "Views",
            dependencies: [
                "Contexts",
                "Controllers",
                "Errors",
                "Models",
                "Utils",
                .product(name: "AuthLib", package: "AuthLib")
            ]
        ),
    ]
)
