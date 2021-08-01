import Contacts
import EmployeesCommon
import EmployeesDomain
import EmployeesListInteracting
import UIKit

public final class EmployeesListViewController: UITableViewController {
    
    private var interactor: EmployeesListInteracting!
    private var dataSource: [EmployeesList] = [] { didSet { tableView.reloadData() } }
    private let localization: EmployeesListLocalization
    private let searchController = UISearchController()
    
    public init(localization: EmployeesListLocalization) {
        self.localization = localization
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        onViewDidLoad()
    }
    
    private func setupUI() {
        title = localization.mainTitle
        
        tableView.register(EmployeeTableViewCell.self)
        
        refreshControl = .init()
        refreshControl?.backgroundColor = view.backgroundColor
        refreshControl?.addTarget(self, action: #selector(userDidRequestUpdate), for: UIControl.Event.valueChanged)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()
    }
    
    private func onViewDidLoad() {
        refreshControl?.beginRefreshing()
        interactor?.event(.userDidRequestInitData)
    }

    @objc private func userDidRequestUpdate() {
        interactor?.event(.userDidRequestUpdate)
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].employees.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.config(with: dataSource[indexPath.section].employees[indexPath.row])
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataSource[section].position
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource[indexPath.section].employees[indexPath.row]
        searchController.isActive = false
        interactor?.event(.employeeDidSelect(item))
    }
    
    public override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let item = dataSource[indexPath.section].employees[indexPath.row]
        searchController.isActive = false
        interactor.event(.userDidRequestOpenBuiltInContact(item))
    }
}

extension EmployeesListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        interactor?.event(.searchTextDidChange(searchController.isActive, searchController.searchBar.text))
    }
}

extension EmployeesListViewController: EmployeesListViewable {
    
    public func setInteractor(_ interactor: EmployeesListInteracting) {
        self.interactor = interactor
    }
    
    public func dataDidUpdate(_ data: [EmployeesList]) {
        refreshControl?.endRefreshing()
        dataSource = data
    }
    
    public func error(_ error: ApplicationError) {
        let alertController = UIAlertController(title: nil, message: error.localizedErrorMessage(with: localization), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: localization.okayButtonTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: { self.refreshControl?.endRefreshing() })
    }
    
    public func openContact(_ contact: CNContact) {
        show(contact: contact)
    }
}

private extension ApplicationError {
    func localizedErrorMessage(with localization: EmployeesListLocalization) -> String {
        switch self {
        case .commonError:
            return localization.genericError
        }
    }
}
