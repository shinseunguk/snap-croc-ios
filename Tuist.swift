import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["16.2"],
    swiftVersion: "5.9.0",
    generationOptions: .options(
        resolveDependenciesWithSystemScm: true,
        disablePackageVersionLocking: false
    )
)
