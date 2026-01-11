import ProjectDescription

extension Project {
    public static func app(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil
    ) -> Project {
        return Project(
            name: name,
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .app,
                    bundleId: "io.tuist.snap-croc-ios",
                    infoPlist: .extendingDefault(
                        with: [
                            "UILaunchStoryboardName": "LaunchScreen",
                            "API_BASE_URL": "$(API_BASE_URL)",
                            "CFBundleURLTypes": [
                                [
                                    "CFBundleTypeRole": "Editor",
                                    "CFBundleURLSchemes": ["com.googleusercontent.apps.YOUR_REVERSED_CLIENT_ID"]
                                ]
                                // Kakao는 Tuist 호환성 문제로 임시 비활성화
                                // [
                                //     "CFBundleTypeRole": "Editor",
                                //     "CFBundleURLSchemes": ["kakaoYOUR_KAKAO_APP_KEY"]
                                // ]
                            ]
                            // "LSApplicationQueriesSchemes": [
                            //     "kakaokompassauth",
                            //     "kakaolink",
                            //     "kakao"
                            // ],
                            // "KAKAO_APP_KEY": "YOUR_KAKAO_APP_KEY"
                        ]
                    ),
                    sources: ["Sources/**"],
                    resources: resources,
                    entitlements: entitlements,
                    dependencies: dependencies
                ),
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "io.tuist.snap-croc-ios.\(name)Tests",
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [.target(name: name)]
                )
            ]
        )
    }

    public static func framework(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil
    ) -> Project {
        return Project(
            name: name,
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "io.tuist.snap-croc-ios.\(name)",
                    infoPlist: .default,
                    sources: ["Sources/**"],
                    resources: resources,
                    dependencies: dependencies
                ),
                .target(
                    name: "\(name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "io.tuist.snap-croc-ios.\(name)Tests",
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [.target(name: name)]
                )
            ]
        )
    }
}
