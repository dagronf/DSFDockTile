// swift-tools-version: 5.4

import PackageDescription

let package = Package(
	name: "DSFDockTile",
	platforms: [
		.macOS(.v10_13),
	],
	products: [
		.library(
			name: "DSFDockTile",
			targets: ["DSFDockTile"]),
	],
	dependencies: [
		.package(name: "DSFImageFlipbook", url: "https://github.com/dagronf/DSFImageFlipbook", from: Version(1, 0, 0))
	],
	targets: [
		.target(
			name: "DSFDockTile",
			dependencies: ["DSFImageFlipbook"],
			resources: [
				.copy("PrivacyInfo.xcprivacy"),
			]
		),
		.testTarget(
			name: "DSFDockTileTests",
			dependencies: ["DSFDockTile"]),
	]
)
