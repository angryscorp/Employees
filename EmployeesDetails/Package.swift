// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "EmployeesDetails",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "EmployeesDetails",
            targets: [
                "EmployeesDetailsPresentation",
                "EmployeesDetailsInteracting"
            ]
        )
    ],
    dependencies: [
        .package(path: "./EmployeesCore")

    ],
    targets: [
        .target(
            name: "EmployeesDetailsInteracting",
            dependencies: ["EmployeesCore"]
        ),
        .target(
            name: "EmployeesDetailsPresentation",
            dependencies: [
                "EmployeesCore",
                "EmployeesDetailsInteracting"
            ]
        )
    ]
)
