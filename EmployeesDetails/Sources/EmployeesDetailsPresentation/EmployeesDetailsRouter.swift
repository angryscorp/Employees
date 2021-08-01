import UIKit
import EmployeesDetailsInteracting

public final class EmployeesDetailsRouter: EmployeesDetailsRouting {
    
    private let viewController: UIViewController & EmployeesDetailsViewable
    private let rootViewController: UIViewController
    
    public init(
        viewController: UIViewController & EmployeesDetailsViewable,
        rootViewController: UIViewController
    ) {
        self.viewController = viewController
        self.rootViewController = rootViewController
    }
    
    public func start(with interactor: EmployeesDetailsInteracting) {
        viewController.setInteractor(interactor)
        rootViewController.show(viewController, sender: nil)
    }
}
