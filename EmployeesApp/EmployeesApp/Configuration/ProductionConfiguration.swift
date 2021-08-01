import Foundation

struct ProductionConfiguration: Configuration {
    var tallinnEmployeeList = URL(string: "https://tallinn-jobapp.aw.ee/employee_list")!
    var tartuEmployeeList = URL(string: "https://tartu-jobapp.aw.ee/employee_list")!
}
