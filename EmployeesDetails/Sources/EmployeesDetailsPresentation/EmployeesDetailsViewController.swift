import UIKit
import EmployeesCommon
import EmployeesDetailsInteracting
import Contacts

public final class EmployeesDetailsViewController: UITableViewController {
    
    private var interactor: EmployeesDetailsInteracting!
    private var dataSource: EmployeesDetails? = nil { didSet { tableView.reloadData() } }
    private let builtInContactButton = UIButton(type: .system)
    private let localization: EmployeesDetailsLocalization
    
    public init(localization: EmployeesDetailsLocalization) {
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
    
    private func onViewDidLoad() {
        interactor?.event(.userDidRequestStart)
    }
    
    private func setupUI() {
        title = localization.mainTitle
        
        tableView.allowsSelection = false
        tableView.register(EmployeeMainInfoTableViewCell.self)
        tableView.register(EmployeeProjectInfoTableViewCell.self)
        
        builtInContactButton.setTitle(localization.builtInContactButtonTitle, for: .normal)
        builtInContactButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        builtInContactButton.addTarget(self, action: #selector(builtInContactButtonDidTap), for: .touchUpInside)
        builtInContactButton.sizeToFit()
        builtInContactButton.isHidden = true
        tableView.tableFooterView = builtInContactButton
    }
    
    @objc private func builtInContactButtonDidTap() {
        interactor.event(.userDidRequestOpenBuiltInContact)
    }

    public override func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.map { 1 + ($0.projects.isEmpty ? 0 : 1) } ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.map { section == 0 ? $0.mainInfo.count : $0.projects.count } ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: EmployeeMainInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let item = dataSource?.mainInfo[indexPath.row]
            item.map { cell.config(with: localization, typeInfo: $0.type, value: $0.value) }
            return cell
        } else {
            let cell: EmployeeProjectInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            let item = dataSource?.projects[indexPath.row]
            item.map { cell.config(with: $0) }
            return cell
        }
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? localization.sectionMainInfo : localization.sectionProjects
    }
}

extension EmployeesDetailsViewController: EmployeesDetailsViewable {
    
    public func setInteractor(_ interactor: EmployeesDetailsInteracting) {
        self.interactor = interactor
    }
    
    public func dataDidUpdate(_ data: EmployeesDetails) {
        dataSource = data
        builtInContactButton.isHidden = !data.hasBuiltInContact
    }
    
    public func openContact(_ contact: CNContact) {
        show(contact: contact)
    }
}
