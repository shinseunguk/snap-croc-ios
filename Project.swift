import ProjectDescription

let project = Project(
    name: "snap-croc-ios",
    targets: [
        .target(
            name: "snap-croc-ios",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.snap-croc-ios",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["snap-croc-ios/Sources/**"],
            resources: ["snap-croc-ios/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "snap-croc-iosTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.snap-croc-iosTests",
            infoPlist: .default,
            sources: ["snap-croc-ios/Tests/**"],
            resources: [],
            dependencies: [.target(name: "snap-croc-ios")]
        ),
    ]
)
