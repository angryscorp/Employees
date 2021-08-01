import Foundation
import EmployeesDomain

public protocol RestAPIClient {
    func get(with url: URL, handler: @escaping (Result<Data, ApplicationError>) -> Void)
}
