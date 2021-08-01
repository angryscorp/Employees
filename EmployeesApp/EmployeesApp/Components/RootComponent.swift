import UIKit

struct RootComponent {
    let window: UIWindow
    let configuration: Configuration
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        configuration = Self.configuration
        rootViewController = UINavigationController()
    }
    
    func makeRootScene() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        makeEmployeesList()
    }
    
    private func makeEmployeesList() {
        EmployeesListComponent(parent: self)
            .makeEmployeesList(setRootViewController: setRootViewController)
    }
    
    private func setRootViewController(viewController: UIViewController) {
        rootViewController.viewControllers = [viewController]
    }
}

private extension RootComponent {
    static var configuration: Configuration {
        #if DEV
            return DevelopmentConfiguration()
        #else
            return ProductionConfiguration()
        #endif
    }
}
