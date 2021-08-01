import EmployeesDomain
import EmployeesListInteracting
import UIKit

public final class EmployeesListRouter: EmployeesListRouting {
    
    private let viewController: UIViewController & EmployeesListViewable
    private let setRootViewController: (UIViewController) -> Void
    private let makeEmployeesDetails: (UIViewController, Employee) -> Void
    
    public init(
        viewController: UIViewController & EmployeesListViewable,
        setRootViewController: @escaping (UIViewController) -> Void,
        makeEmployeesDetails: @escaping (UIViewController, Employee) -> Void
    ) {
        self.viewController = viewController
        self.setRootViewController = setRootViewController
        self.makeEmployeesDetails = makeEmployeesDetails
    }
        
    public func start(with interactor: EmployeesListInteracting) {
        viewController.setInteractor(interactor)
        setRootViewController(viewController)
    }
    
    public func routeToEmployeeDetails(with employee: Employee) {
        makeEmployeesDetails(viewController, employee)
    }
}
