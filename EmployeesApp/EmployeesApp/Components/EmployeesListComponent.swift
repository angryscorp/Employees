import UIKit
import BuiltInContactsStore
import BuiltInContactsStoreImpl
import EmployeesDomain
import EmployeesListGatewayImpl
import EmployeesListInteracting
import EmployeesListPresentation
import EmployeesNetworkImpl

struct EmployeesListComponent {
    let parent: RootComponent
    let builtInContactsStore: BuiltInContactsStore
    
    init(parent: RootComponent) {
        self.parent = parent
        builtInContactsStore = BuiltInContactsStoreImpl(store: .init())
    }
    
    func makeEmployeesList(setRootViewController: @escaping (UIViewController) -> Void) {
        let viewController = EmployeesListViewController(
            localization: .init(
                mainTitle: localizedString("mainTitle"),
                genericError: localizedString("genericError"),
                okayButtonTitle: localizedString("okayButtonTitle")
            )
        )
        
        let router = EmployeesListRouter(
            viewController: viewController,
            setRootViewController: setRootViewController,
            makeEmployeesDetails: makeEmployeesDetails
        )

        let interactor = EmployeesListInteractor(
            router: router,
            contactsStore: builtInContactsStore,
            employeesListCacheStore: EmployeesListCacheStoreImpl(userDefaults: .standard),
            viewController: viewController,
            gateway: EmployeesListGatewayImpl(
                restAPIClient: RestAPIClientImpl(session: .shared),
                endpoints: [
                    parent.configuration.tallinnEmployeeList,
                    parent.configuration.tartuEmployeeList
                ]
            )
        )
        
        router.start(with: interactor)
    }
    
    private func makeEmployeesDetails(on viewController: UIViewController, for employee: Employee) {
        EmployeesDetailsComponent(parent: self)
            .makeEmployeesDetails(on: viewController, for: employee)
    }
    
    private func localizedString(_ key: String) -> String {
        NSLocalizedString(key, tableName: "EmployeesList", comment: "")
    }
}
