import EmployeesDomain

struct EmployeesListState {
    var mode: Mode = .fullList
    var fullData: [Employee] = []
    var actualData: [EmployeesList] {
        switch mode {
        case .fullList:
            return fullData.toEmployeesList()
        case let .search(text):
            return (text.map { fullData.search(with: $0.lowercased()) } ?? fullData).toEmployeesList()
        }
    }
}

extension EmployeesListState {
    enum Mode: Equatable {
        case fullList
        case search(String?)
    }
}

extension Array where Element == Employee {
    func toEmployeesList() -> [EmployeesList] {
        Set(map { $0.position }).sorted().map { position in
            EmployeesList(
                position: position.rawValue,
                employees: filter { $0.position == position }.sorted()
            )
        }
    }
}

extension Employee.Position: Comparable {
    public static func < (lhs: Employee.Position, rhs: Employee.Position) -> Bool {
        lhs.rawValue.lowercased() < rhs.rawValue.lowercased()
    }
}

extension Employee: Comparable {
    public static func < (lhs: Employee, rhs: Employee) -> Bool {
        lhs.lastName.lowercased() < rhs.lastName.lowercased()
    }

    public static func == (lhs: Employee, rhs: Employee) -> Bool {
        lhs.firstName.lowercased() == rhs.firstName.lowercased()
            && lhs.lastName.lowercased() == rhs.lastName.lowercased()
    }
}

private extension Array where Element == Employee {
    func search(with text: String) -> [Employee] {
        guard !text.isEmpty else {
            return self
        }
        return filter { employee in
            employee.searchFields.map { $0.lowercased().contains(text) }.contains(true)
        }
    }
}

private extension Employee {
    var searchFields: [String] {
        [email, lastName, firstName, position.rawValue] + projects
    }
}
