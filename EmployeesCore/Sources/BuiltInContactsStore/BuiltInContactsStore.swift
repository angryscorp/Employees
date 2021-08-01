import Contacts

public protocol BuiltInContactsStore {
    func getAllContacts(handler: @escaping ([BuiltinContact]?) -> Void)
    func getContact(by id: String) -> CNContact?
}
