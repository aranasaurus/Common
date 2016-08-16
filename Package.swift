import PackageDescription

let package = Package(
    name: "Common",
    targets: [
        Target(
            name: "Common",
            dependencies: []
        )
    ],
    dependencies: [
        .Package(url: "https://github.com/ketzusaka/Strand.git", majorVersion: 1, minor: 6)
    ],
    exclude: [
        "XcodeProject"
    ]
)
