import Foundation
import EmployeesDomain
import EmployeesNetwork

public final class RestAPIClientImpl: RestAPIClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func get(with url: URL, handler: @escaping (Result<Data, ApplicationError>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data
            else {
                handler(.failure(.commonError))
                return
            }
            handler(.success(data))
        }.resume()
    }
}
