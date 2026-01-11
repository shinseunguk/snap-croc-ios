// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        productTypes: [
            "ComposableArchitecture": .framework,
            "GoogleSignIn": .framework,
            "GoogleSignInSwift": .framework
        ]
    )
#endif

let package = Package(
    name: "snap-croc-ios",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.16.1"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS", from: "7.0.0")
        // Kakao SDK는 Tuist 호환성 문제로 인해 임시 비활성화
        // .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.20.0")
    ]
)
