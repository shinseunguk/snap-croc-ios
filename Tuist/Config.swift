import ProjectDescription

let config = Config(
    compatibleXcodeVersions: ["15.0"],
    swiftVersion: "5.9.0",
    generationOptions: .options(
        resolveDependenciesWithSystemScm: true,
        disablePackageVersionLocking: false
    )
)
