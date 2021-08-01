import EmployeesDomain

struct EmployeesDetailsState {
    var employeesDetails: EmployeesDetails? = nil
}

public struct EmployeesDetails {
    public let hasBuiltInContact: Bool
    public let mainInfo: [(type: InfoType, value: String)]
    public let projects: [String]
}

public extension EmployeesDetails {
    enum InfoType {
        case fullName
        case position
        case email
        case phoneNumber
    }
}

extension EmployeesDetails {
    init(employee: Employee) {
        var mainInfo: [(type: EmployeesDetails.InfoType, value: String)] =  [
            (type: .fullName, value: employee.fullName),
            (type: .position, value: employee.position.rawValue),
            (type: .email, value: employee.email)
        ]
        employee.phone.map { mainInfo.append((type: .phoneNumber, value: $0)) }
        self.init(
            hasBuiltInContact: employee.builtInId != nil,
            mainInfo: mainInfo,
            projects: employee.projects
        )
    }
}
