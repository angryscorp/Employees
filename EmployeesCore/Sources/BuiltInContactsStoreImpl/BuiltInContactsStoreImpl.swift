import BuiltInContactsStore
import Contacts
import ContactsUI

public class BuiltInContactsStoreImpl: BuiltInContactsStore {
    
    private let store: CNContactStore
    
    public init(store: CNContactStore) {
        self.store = store
    }
    
    public func getAllContacts(handler: @escaping ([BuiltinContact]?) -> Void) {
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                handler(nil)
                return
            }
            
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            var result = [BuiltinContact]()
            try? self.store.enumerateContacts(with: request) {  (contact, stopPointer) in
                result.append(
                    .init(
                        id: contact.identifier,
                        givenName: contact.givenName,
                        familyName: contact.familyName
                    )
                )
            }
            handler(result)
        }
    }
    
    public func getContact(by id: String) -> CNContact? {
        let predicate = CNContact.predicateForContacts(withIdentifiers: [id])
        let keys = CNContactViewController.descriptorForRequiredKeys()
        return try? CNContactStore().unifiedContacts(matching: predicate, keysToFetch: [keys] as [CNKeyDescriptor]).first
    }
}
