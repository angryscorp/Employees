import EmployeesDomain
import Foundation

public struct EmployeesDTO: Codable {
    let employees: [EmployeeDTO]
}

public struct EmployeeDTO: Codable {
    public let fname: String
    public let lname: String
    public let contactDetails: ContactDetails
    public let position: Position
    public let projects: [String]?
}

public extension Array where Element == EmployeeDTO {
    static func decode(from data: Data) -> Result<[EmployeeDTO], ApplicationError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try? decoder.decode(EmployeesDTO.self, from: data).employees
        return result.map { Result.success($0) } ?? .failure(.commonError)
    }
}

public extension EmployeeDTO {
    
    struct ContactDetails: Codable {
        let email: String
        let phone: String?
    }
    
    enum Position: String, Codable {
        case IOS
        case ANDROID
        case WEB
        case PM
        case TESTER
        case SALES
        case OTHER
    }
}

public extension Employee {
    init(dto: EmployeeDTO, builtInIdByFullName: (_ fName: String, _ lName: String) -> String?) {
        self.init(
            builtInId: builtInIdByFullName(dto.fname, dto.lname),
            firstName: dto.fname,
            lastName: dto.lname,
            email: dto.contactDetails.email,
            phone: dto.contactDetails.phone,
            position: .init(dto: dto.position),
            projects: dto.projects ?? []
        )
    }
}

private extension Employee.Position {
    init(dto: EmployeeDTO.Position) {
        switch dto {
        case .IOS:
            self = .iOS
        case .ANDROID:
            self = .Android
        case .WEB:
            self = .WEB
        case .PM:
            self = .PM
        case .TESTER:
            self = .Tester
        case .SALES:
            self = .Sales
        case .OTHER:
            self = .Other
        }
    }
}
