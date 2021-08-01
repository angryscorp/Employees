import EmployeesDomain
import UIKit

final class EmployeeTableViewCell: UITableViewCell {
    
    func config(with employee: Employee) {
        textLabel?.text =  employee.fullName
        accessoryType = employee.builtInId == nil ? .disclosureIndicator : .detailDisclosureButton
    }
}
