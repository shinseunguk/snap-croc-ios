import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Presentation",
    dependencies: [
        .Module.domain,
        .Module.data,
        .Module.shared,
        .External.tca
    ],
    resources: ["Resources/**"]
)
