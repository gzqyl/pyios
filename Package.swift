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
        .binaryTarget(name: "libpython3", url: "https://github.com/gzqyl/pyios/releases/download/v1.0.1/libpython3.11.xcframework.zip", checksum: "368d96bb8e08dfc50784d52e98115908c12a6bae1f040f253645cd02d9e95238"),
        .binaryTarget(name: "libssl", url: "https://github.com/gzqyl/pyios/releases/download/v1.0.1/libssl.xcframework.zip", checksum: "3891a2336b49038d9423f379dba8a6b287c2ae11e833fdd4b2e3047aac665159"),
        .binaryTarget(name: "libcrypto", url: "https://github.com/gzqyl/pyios/releases/download/v1.0.1/libcrypto.xcframework.zip", checksum: "03fb7ab95c2e91e1b2477e02943d619c642f3b08ee238bd01454c5ee19cd9070"),
        .binaryTarget(name: "libffi", url: "https://github.com/gzqyl/pyios/releases/download/v1.0.1/libffi.xcframework.zip", checksum: "815f5a0c30b89fcca21ca15ccacf3ee35defd9a27f3a5bf6a205e8bac06f13f0"),
        .target(
            name: "LinkPython",
            dependencies: [
                "libpython3",
                "libssl",
                "libcrypto",
                "libffi",
            ],
            cSettings: [
                .headerSearchPath("./python3.11"),
                .headerSearchPath("./python3.11/cpython"),
                .headerSearchPath("./python3.11/internal"),
                .headerSearchPath("./openssl/crypto"),
                .headerSearchPath("./openssl/internal"),
                .headerSearchPath("./openssl/openssl"),
                .headerSearchPath("./ffi")
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
            ]
        ),
        .target(
            name: "PythonSupport",
            dependencies: ["LinkPython"],
            cSettings: [
                .headerSearchPath("./python3.11"),
                .headerSearchPath("./python3.11/cpython"),
                .headerSearchPath("./python3.11/internal"),
                .headerSearchPath("./openssl/crypto"),
                .headerSearchPath("./openssl/internal"),
                .headerSearchPath("./openssl/openssl"),
                .headerSearchPath("./ffi")
            ],
            resources: [.copy("lib")]
        ),
        .testTarget(
            name: "PythonTests",
            dependencies: ["PythonSupport"],
            cSettings: [
                .headerSearchPath("./python3.11"),
                .headerSearchPath("./python3.11/cpython"),
                .headerSearchPath("./python3.11/internal"),
                .headerSearchPath("./openssl/crypto"),
                .headerSearchPath("./openssl/internal"),
                .headerSearchPath("./openssl/openssl"),
                .headerSearchPath("./ffi")
            ]
        ),
    ]
)
