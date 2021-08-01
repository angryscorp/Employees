import Contacts
import EmployeesDomain

public protocol EmployeesListInteracting: AnyObject {
    func event(_ event: EmployeesListEvent)
}

public protocol EmployeesListViewable: AnyObject {
    func setInteractor(_ interactor: EmployeesListInteracting)
    func dataDidUpdate(_ data: [EmployeesList])
    func error(_ error: ApplicationError)
    func openContact(_ contact: CNContact)
}

public protocol EmployeesListRouting: AnyObject {
    func start(with interactor: EmployeesListInteracting)
    func routeToEmployeeDetails(with employee: Employee)
}

public enum EmployeesListEvent {
    case userDidRequestInitData
    case userDidRequestUpdate
    case employeeDidSelect(Employee)
    case searchTextDidChange(Bool, String?)
    case userDidRequestOpenBuiltInContact(Employee)
}

public struct EmployeesList {
    public let position: String
    public let employees: [Employee]
}
