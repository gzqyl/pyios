// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Python-iOS",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "Python-iOS",
            targets: [ // order matters!
                "LinkPython",
                "libpython3", "libssl", "libcrypto", "libffi",
                "PythonSupport",
            ]),
    ],
    targets: [
        .binaryTarget(name: "libpython3", url: "https://github.com/gzqyl/numpyios/releases/download/v2.0.1/libpython3.11.xcframework.zip"),
        .binaryTarget(name: "libssl", url: "https://github.com/gzqyl/numpyios/releases/download/v2.0.1/libssl.xcframework.zip"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/gzqyl/numpyios/releases/download/v2.0.1/libcrypto.xcframework.zip"),
        .binaryTarget(name: "libffi", url: "https://github.com/gzqyl/numpyios/releases/download/v2.0.1/libffi.xcframework.zip"),
        .target(name: "LinkPython",
                dependencies: [
                    "libpython3",
                    "libssl",
                    "libcrypto",
                    "libffi",
                ],
                linkerSettings: [
                    .linkedLibrary("z"),
                    .linkedLibrary("sqlite3"),
                ]
        ),
        .target(name: "PythonSupport",
                dependencies: ["LinkPython"],
                resources: [.copy("lib")]),
        .testTarget(
            name: "PythonTests",
            dependencies: ["PythonSupport"]),
    ]
)
