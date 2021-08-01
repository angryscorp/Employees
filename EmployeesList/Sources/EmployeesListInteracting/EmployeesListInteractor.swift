import BuiltInContactsStore
import EmployeesDomain
import EmployeesListGateway
import Foundation

public final class EmployeesListInteractor: EmployeesListInteracting {
    
    private var state: EmployeesListState = .init() {
        didSet { viewController?.dataDidUpdate(state.actualData) }
    }
    
    private var router: EmployeesListRouting
    private let contactsStore: BuiltInContactsStore
    private let employeesListCacheStore: EmployeesListCacheStore
    private let gateway: EmployeesListGateway
    private weak var viewController: EmployeesListViewable?
        
    public init(
        router: EmployeesListRouting,
        contactsStore: BuiltInContactsStore,
        employeesListCacheStore: EmployeesListCacheStore,
        viewController: EmployeesListViewable,
        gateway: EmployeesListGateway
    ) {
        self.router = router
        self.contactsStore = contactsStore
        self.employeesListCacheStore = employeesListCacheStore
        self.viewController = viewController
        self.gateway = gateway
    }
    
    public func event(_ event: EmployeesListEvent) {
        switch event {
        case let .searchTextDidChange(isActive, searchText):
            state.mode = isActive ? .search(searchText) : .fullList
        case let .employeeDidSelect(employee):
            router.routeToEmployeeDetails(with: employee)
        case .userDidRequestInitData:
            restoreFromCache()
            updateData()
        case .userDidRequestUpdate:
            updateData()
        case let .userDidRequestOpenBuiltInContact(contact):
            guard
                let id = contact.builtInId,
                let contact = contactsStore.getContact(by: id)
            else {
                return
            }
            viewController?.openContact(contact) 
        }
    }
    
    private func restoreFromCache() {
        guard let dtos = employeesListCacheStore.get() else {
            return
        }
        contactsStore.getAllContacts { contacts in
            DispatchQueue.main.async {
                self.state.fullData = dtos.toEmployees(with: contacts ?? [])
            }
        }
    }
    
    private func updateData() {
        gateway.loadEmployeesList { result in
            switch result {
            case let .success(dtos):
                self.employeesListCacheStore.set(dtos)
                self.contactsStore.getAllContacts { contacts in
                    DispatchQueue.main.async {
                        self.state.fullData = dtos.toEmployees(with: contacts ?? [])
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.viewController?.error(error)
                }
            }
        }
    }
}

private extension Array where Element == EmployeeDTO {
    func toEmployees(with contacts: [BuiltinContact]) -> [Employee] {
        reduce(into: [Employee]()) { result, next in
            guard !result.contains(where: { $0.firstName == next.fname && $0.lastName == next.lname }) else {
                return
            }
            result.append(.init(dto: next, builtInIdByFullName: contacts.getId))
        }
    }
}

private extension Array where Element == BuiltinContact {
    func getId(fName: String, lName: String ) -> String? {
        first(where: { contact in
                contact.familyName.lowercased() == lName.lowercased()
                && contact.givenName.lowercased() == fName.lowercased()
        })?.id
    }
}
