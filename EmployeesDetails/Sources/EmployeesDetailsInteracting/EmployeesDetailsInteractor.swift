import BuiltInContactsStore
import EmployeesDomain

public final class EmployeesDetailsInteractor: EmployeesDetailsInteracting {
    
    private var state: EmployeesDetailsState = .init() {
        didSet { state.employeesDetails.map { viewController?.dataDidUpdate($0) } }
    }
    
    private let employee: Employee
    private let contactsStore: BuiltInContactsStore
    private let router: EmployeesDetailsRouting
    private weak var viewController: EmployeesDetailsViewable?
        
    public init(
        employee: Employee,
        contactsStore: BuiltInContactsStore,
        router: EmployeesDetailsRouting,
        viewController: EmployeesDetailsViewable
    ) {
        self.employee = employee
        self.contactsStore = contactsStore
        self.router = router
        self.viewController = viewController
    }

    public func event(_ event: EmployeesDetailsEvent) {
        switch event {
        case .userDidRequestStart:
            state.employeesDetails = .init(employee: employee)
        case .userDidRequestOpenBuiltInContact:
            guard let id = employee.builtInId, let contact = contactsStore.getContact(by: id) else {
                return
            }
            viewController?.openContact(contact)
        }
    }
}
