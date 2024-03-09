// swift-tools-version: 5.9
// swiftlint:disable explicit_acl explicit_top_level_acl
import PackageDescription

let package = Package(
  name: "IPSWDownloads",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)],
  products: [
    .library(name: "IPSWDownloads", targets: ["IPSWDownloads"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/brightdigit/OperatingSystemVersion",
      from: "1.0.0-beta.1"
    ),
    .package(
      url: "https://github.com/apple/swift-openapi-generator",
      from: "1.0.0"
    ),
    .package(
      url: "https://github.com/apple/swift-openapi-runtime",
      from: "1.0.0"
    ),
    .package(
      url: "https://github.com/apple/swift-openapi-urlsession",
      from: "1.0.0"
    )
  ],
  targets: [
    .target(
      name: "IPSWDownloads",
      dependencies: [
        .product(name: "OperatingSystemVersion", package: "OperatingSystemVersion"),
        .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
        .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession")
      ],
      swiftSettings: [
        .enableUpcomingFeature("BareSlashRegexLiterals"),
        .enableUpcomingFeature("ConciseMagicFile"),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("ForwardTrailingClosures"),
        .enableUpcomingFeature("ImplicitOpenExistentials"),
        .enableUpcomingFeature("StrictConcurrency"),
        .enableUpcomingFeature("DisableOutwardActorInference"),
        .enableExperimentalFeature("StrictConcurrency")
      ]
    ),
    .testTarget(
      name: "IPSWDownloadsTests",
      dependencies: ["IPSWDownloads"]
    )
  ]
)
// swiftlint:enable explicit_acl explicit_top_level_acl
