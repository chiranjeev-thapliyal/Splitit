//
//  ContactManager.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/05/24.
//

import Contacts

struct Contact: Codable, Identifiable, Hashable {
    let id = UUID()
    var name: String
    var email: String
    var image: String
    var isFriend: Bool = false
}

class ContactsManager: ObservableObject {
    @Published var contacts: [Contact] = []
    var friends: [Friend] = []
    
    func updateFriends(newFriends: [Friend]) {
        DispatchQueue.main.async {
            self.friends = newFriends
            self.evaluateFriends()
        }
    }
    
    private func evaluateFriends() {
        contacts = contacts.map { contact in
            var modifiedContact = contact
            if friends.contains(where: { $0.email == contact.email }) {
                modifiedContact.isFriend = true
            }
            return modifiedContact
        }
    }

    func requestAccess(completion: @escaping (Bool) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            DispatchQueue.main.async {
                completion(granted)  // Call completion handler with the 'granted' Boolean
            }
        }
    }

//    func loadContacts() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            let store = CNContactStore()
//            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactemailsKey] as [CNKeyDescriptor]
//            let request = CNContactFetchRequest(keysToFetch: keys)
//            var fetchedContacts = [Contact]()
//            
//            do {
//                try store.enumerateContacts(with: request) { contact, stop in
//                    if let email = contact.emails.first?.value.stringValue {
//                        let fullName = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespacesAndNewlines)
//                        if !fullName.isEmpty {
//                            let newContact = Contact(name: fullName, email: lastTenDigits(of: email.trimmingCharacters(in: .whitespacesAndNewlines)) , image: "profile\(Int.random(in: 2...5))")
//                            fetchedContacts.append(newContact)
//                           
//                        }
//                    }
//                }
//                
//                DispatchQueue.main.async {
//                    self.contacts = fetchedContacts
//                }
//            } catch {
//                DispatchQueue.main.async {
//                   print("Failed to fetch contacts: \(error)")
//               }
//            }
//        }
//    }
}

