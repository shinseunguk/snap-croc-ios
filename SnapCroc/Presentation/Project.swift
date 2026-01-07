import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Presentation",
    dependencies: [
        .Module.domain,
        .Module.shared
    ],
    resources: ["Resources/**"]
)
