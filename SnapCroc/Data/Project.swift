import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Data",
    dependencies: [
        .Module.domain,
        .Module.shared,
        .External.googleSignIn
    ]
)
