public struct EmployeesDetailsLocalization {
    let mainTitle: String
    let builtInContactButtonTitle: String
    let sectionMainInfo: String
    let sectionProjects: String
    let fullNameTitle: String
    let positionTitle: String
    let emailTitle: String
    let phoneNumberTitle: String
    
    public init(
        mainTitle: String,
        builtInContactButtonTitle: String,
        sectionMainInfo: String,
        sectionProjects: String,
        fullNameTitle: String,
        positionTitle: String,
        emailTitle: String,
        phoneNumberTitle: String
    ) {
        self.mainTitle = mainTitle
        self.builtInContactButtonTitle = builtInContactButtonTitle
        self.sectionMainInfo = sectionMainInfo
        self.sectionProjects = sectionProjects
        self.fullNameTitle = fullNameTitle
        self.positionTitle = positionTitle
        self.emailTitle = emailTitle
        self.phoneNumberTitle = phoneNumberTitle
    }
}
