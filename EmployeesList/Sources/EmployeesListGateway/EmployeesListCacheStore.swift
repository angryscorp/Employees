public protocol EmployeesListCacheStore: AnyObject {
    func set(_ employees: [EmployeeDTO])
    func get() -> [EmployeeDTO]?
}
