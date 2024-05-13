//
//  ContactList.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/05/24.
//

import SwiftUI
import Contacts

struct ContactList: View {
    @ObservedObject var contactsManager = ContactsManager()
    @ObservedObject var friendsViewModel = FriendsViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    func loadAndSyncContacts(){
        self.friendsViewModel.getFriends()
//        self.contactsManager.loadContacts()
        self.contactsManager.updateFriends(newFriends: self.friendsViewModel.friends)
    }
    
//    func syncContactsAndFriends() {
//        let accessStatus = CNContactStore.authorizationStatus(for: .contacts)
//        
//        if accessStatus != .authorized {
//            contactsManager.requestAccess { granted in
//                if granted {
//                    loadAndSyncContacts()
//                } else {
//                    self.showingPermissionDeniedAlert = true
//                }
//            }
//        } else {
//           loadAndSyncContacts()
//        }
//    }

    var body: some View {
        NavigationView {
            List {
                ForEach(contactsManager.contacts.sorted(by: {$0.name < $1.name}) , id: \.self) { contact in
                    HStack {
                        Image(contact.image)  // Display friend's image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .shadow(radius: 3)

                        Text(contact.name)
                            .font(.headline)
                            .padding(.leading, 8)

                        Spacer()

                        if !contact.isFriend {
                            Button(action: {
                                friendsViewModel.checkAndAddContact(contact: contact)
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title)
                            }
                        } else {
                            Button(action: {
                                print("Already a friend")
                            }) {
                                Image(systemName: "checkmark.seal")
                                    .foregroundColor(.green)
                                    .font(.title)
                            }
                        }
                    }
                }
            }
            .onAppear {
//                syncContactsAndFriends()
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactList()
}
