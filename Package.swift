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
    ],
    exclude: [
        "XcodeProject"
    ]
)
