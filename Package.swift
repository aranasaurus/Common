import PackageDescription

let package = Package(
    name: "Common",
    targets: [
        Target(name: "Common")
    ],
    dependencies: [
        .Package(url: "https://github.com/DanToml/Jay.git", majorVersion: 0, minor: 21)
    ],
    exclude: [
        "XcodeProject"
    ]
)
