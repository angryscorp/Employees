// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "EmployeesCore",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "EmployeesCore",
            targets: [
                "EmployeesDomain",
                "EmployeesCommon",
                "EmployeesNetwork",
                "EmployeesNetworkImpl",
                "BuiltInContactsStore",
                "BuiltInContactsStoreImpl"
            ]
        )
    ],
    targets: [
        .target(name: "EmployeesDomain"),
        .target(name: "EmployeesCommon"),
        .target(
            name: "EmployeesNetwork",
            dependencies: ["EmployeesDomain"]
        ),
        .target(
            name: "EmployeesNetworkImpl",
            dependencies: [
                "EmployeesDomain",
                "EmployeesNetwork"
            ]
        ),
        .target(name: "BuiltInContactsStore"),
        .target(
            name: "BuiltInContactsStoreImpl",
            dependencies: ["BuiltInContactsStore"]
        )
    ]
)
