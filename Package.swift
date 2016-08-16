import PackageDescription

let package = Package(
    name: "Common",
    targets: [
        Target(name: "Common", dependencies: ["libc"]),
        Target(name: "libc")
    ],
    dependencies: [
    ],
    exclude: [
        "XcodeProject"
    ]
)
