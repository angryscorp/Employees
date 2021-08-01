// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "EmployeesList",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "EmployeesList",
            targets: [
                "EmployeesListGateway",
                "EmployeesListGatewayImpl",
                "EmployeesListInteracting",
                "EmployeesListPresentation"
            ]
        )
    ],
    dependencies: [
        .package(path: "./EmployeesCore")
    ],
    targets: [
        .target(
            name: "EmployeesListGateway",
            dependencies: ["EmployeesCore"]
        ),
        .target(
            name: "EmployeesListGatewayImpl",
            dependencies: [
                "EmployeesCore",
                "EmployeesListGateway"
            ]
        ),
        .target(
            name: "EmployeesListInteracting",
            dependencies: [
                "EmployeesCore",
                "EmployeesListGateway"
            ]
        ),
        .target(
            name: "EmployeesListPresentation",
            dependencies: [
                "EmployeesCore",
                "EmployeesListInteracting"
            ]
        )
    ]
)
