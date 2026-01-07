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
}
