public struct Employee {
    public let builtInId: String?
    public let firstName: String
    public let lastName: String
    public let email: String
    public let phone: String?
    public let position: Position
    public let projects: [String]
    
    public init(
        builtInId: String?,
        firstName: String,
        lastName: String,
        email: String,
        phone: String?,
        position: Position,
        projects: [String]
    ) {
        self.builtInId = builtInId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.position = position
        self.projects = projects
    }
}

extension Employee {
    public var fullName: String {
        firstName + " " + lastName
    }
}

extension Employee {
    public enum Position: String {
        case iOS
        case Android
        case WEB
        case PM
        case Tester
        case Sales
        case Other
    }
}
