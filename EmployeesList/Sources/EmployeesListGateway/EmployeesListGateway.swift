import EmployeesDomain

public protocol EmployeesListGateway: AnyObject {
    func loadEmployeesList(handler: @escaping (Result<[EmployeeDTO], ApplicationError>) -> Void)
}
