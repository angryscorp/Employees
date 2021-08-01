import EmployeesDomain
import EmployeesListGateway
import EmployeesNetwork
import Foundation

public final class EmployeesListGatewayImpl: EmployeesListGateway {
    
    private let restAPIClient: RestAPIClient
    private let endpoints: [URL]
    
    public init(
        restAPIClient: RestAPIClient,
        endpoints: [URL]
    ) {
        self.restAPIClient = restAPIClient
        self.endpoints = endpoints
    }
    
    public func loadEmployeesList(handler: @escaping (Result<[EmployeeDTO], ApplicationError>) -> Void) {
        var error: ApplicationError? = nil
        var result = [EmployeeDTO]()
        
        let serialQueue = DispatchQueue(label: "serialQueue")
        let dispatchGroup = DispatchGroup()
        
        endpoints.forEach { url in
            dispatchGroup.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                self.restAPIClient.get(with: url) { response in
                    defer { dispatchGroup.leave() }
                    switch response {
                    case let .success(data):
                        switch [EmployeeDTO].decode(from: data)  {
                        case let .success(dtos):
                            serialQueue.sync { result += dtos }
                        case let .failure(err):
                            serialQueue.sync { error = err }
                        }
                    case .failure:
                        serialQueue.sync { error = ApplicationError.commonError }
                    }
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            handler(error.map { .failure($0) } ?? .success(result))
        }
    }
}
