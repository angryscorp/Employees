import UIKit
import EmployeesDetailsInteracting

final class EmployeeMainInfoTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with localization: EmployeesDetailsLocalization, typeInfo: EmployeesDetails.InfoType, value: String) {
        textLabel?.text = typeInfo.localizedTitle(with: localization)
        detailTextLabel?.text = value
    }
}

private extension EmployeesDetails.InfoType {
    func localizedTitle(with localization: EmployeesDetailsLocalization) -> String {
        switch self {
        case .fullName:
            return localization.fullNameTitle
        case .email:
            return localization.emailTitle
        case .phoneNumber:
            return localization.phoneNumberTitle
        case .position:
            return localization.positionTitle
        }
    }
}
