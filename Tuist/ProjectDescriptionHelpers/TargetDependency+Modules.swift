import ProjectDescription

extension TargetDependency {
    public enum Module {
        public static let app: TargetDependency = .project(
            target: "App",
            path: .relativeToRoot("SnapCroc/App")
        )

        public static let domain: TargetDependency = .project(
            target: "Domain",
            path: .relativeToRoot("SnapCroc/Domain")
        )

        public static let data: TargetDependency = .project(
            target: "Data",
            path: .relativeToRoot("SnapCroc/Data")
        )

        public static let presentation: TargetDependency = .project(
            target: "Presentation",
            path: .relativeToRoot("SnapCroc/Presentation")
        )

        public static let shared: TargetDependency = .project(
            target: "Shared",
            path: .relativeToRoot("SnapCroc/Shared")
        )
    }

    public enum External {
        public static let tca: TargetDependency = .external(name: "ComposableArchitecture")
        public static let googleSignIn: TargetDependency = .external(name: "GoogleSignIn")
        public static let googleSignInSwift: TargetDependency = .external(name: "GoogleSignInSwift")
        // Kakao SDK는 Tuist 호환성 문제로 인해 임시 비활성화
        // public static let kakaoSDKAuth: TargetDependency = .external(name: "KakaoSDKAuth")
        // public static let kakaoSDKUser: TargetDependency = .external(name: "KakaoSDKUser")
    }
}
