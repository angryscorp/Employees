import Contacts

public protocol EmployeesDetailsInteracting: AnyObject {
    func event(_ event: EmployeesDetailsEvent)
}

public enum EmployeesDetailsEvent {
    case userDidRequestStart
    case userDidRequestOpenBuiltInContact
}

public protocol EmployeesDetailsViewable: AnyObject {
    func setInteractor(_ interactor: EmployeesDetailsInteracting)
    func dataDidUpdate(_ data: EmployeesDetails)
    func openContact(_ contact: CNContact)
}

public protocol EmployeesDetailsRouting: AnyObject {
    func start(with interactor: EmployeesDetailsInteracting)
}

