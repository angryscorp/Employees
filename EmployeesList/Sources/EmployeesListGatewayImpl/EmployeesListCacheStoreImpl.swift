import EmployeesListGateway
import Foundation

public final class EmployeesListCacheStoreImpl: EmployeesListCacheStore {
    
    private let userDefaults: UserDefaults
    private let employeesListStoreKey: String
    
    public init(userDefaults: UserDefaults, employeesListStoreKey: String? = nil) {
        self.userDefaults = userDefaults
        self.employeesListStoreKey = employeesListStoreKey ?? String(describing: Self.self)
    }
    
    public func set(_ employees: [EmployeeDTO]) {
        userDefaults.set(employees.toData(), forKey: employeesListStoreKey)
    }
    
    public func get() -> [EmployeeDTO]? {
        let data = userDefaults.object(forKey: employeesListStoreKey) as? Data
        return data?.toEmployees()
    }
}

private extension Data {
    func toEmployees() -> [EmployeeDTO] {
        (try? JSONDecoder().decode([EmployeeDTO].self, from: self)) ?? []
    }
}

private extension Array where Element == EmployeeDTO {
    func toData() -> Data {
        guard let data = try? JSONEncoder().encode(self) else {
            fatalError("Unexpected error on converting [EmployeeDTO] to Data")
        }
        return data
    }
}
