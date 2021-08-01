import UIKit
import EmployeesDetailsInteracting
import EmployeesDetailsPresentation
import EmployeesDomain

struct EmployeesDetailsComponent {
    let parent: EmployeesListComponent
    
    func makeEmployeesDetails(
        on viewController: UIViewController,
        for employee: Employee
    ) {
        let viewController = EmployeesDetailsViewController(
            localization: .init(
                mainTitle: localizedString("mainTitle"),
                builtInContactButtonTitle: localizedString("builtInContactButtonTitle"),
                sectionMainInfo: localizedString("sectionMainInfo"),
                sectionProjects: localizedString("sectionProjects"),
                fullNameTitle: localizedString("fullNameTitle"),
                positionTitle: localizedString("positionTitle"),
                emailTitle: localizedString("emailTitle"),
                phoneNumberTitle: localizedString("phoneNumberTitle")
            )
        )
       
        let router = EmployeesDetailsRouter(
            viewController: viewController,
            rootViewController: parent.parent.rootViewController
        )
        
        let interactor = EmployeesDetailsInteractor(
            employee: employee,
            contactsStore: parent.builtInContactsStore,
            router: router,
            viewController: viewController
        )
        
        router.start(with: interactor)
    }
    
    private func localizedString(_ key: String) -> String {
        NSLocalizedString(key, tableName: "EmployeesDetails", comment: "")
    }
}
