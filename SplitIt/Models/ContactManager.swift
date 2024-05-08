//
//  ContactManager.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/05/24.
//

import Contacts

struct Contact: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var phoneNumber: String
    var image: String
}

class ContactsManager: ObservableObject {
    @Published var contacts: [Contact] = []

    func requestAccess() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                self.loadContacts()
            } else {
                print("Access denied: \(String(describing: error))")
            }
        }
    }

    func loadContacts() {
        DispatchQueue.global(qos: .userInitiated).async {
            let store = CNContactStore()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keys)
            var fetchedContacts = [Contact]()
            
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                        let fullName = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespacesAndNewlines)
                        if !fullName.isEmpty {
                            let newContact = Contact(name: fullName, phoneNumber: phoneNumber, image: "profile\(Int.random(in: 2...5))")
                            fetchedContacts.append(newContact)
                           
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.contacts = fetchedContacts
                }
            } catch {
                DispatchQueue.main.async {
                   print("Failed to fetch contacts: \(error)")
               }
            }
        }
    }
}

