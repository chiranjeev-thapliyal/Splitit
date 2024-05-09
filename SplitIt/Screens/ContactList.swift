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
    @State private var showingPermissionDeniedAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    func loadAndSyncContacts(){
        self.contactsManager.loadContacts()
        self.contactsManager.updateFriends(newFriends: self.friendsViewModel.friends)
    }
    
    func syncContactsAndFriends() {
        let accessStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        if accessStatus != .authorized {
            contactsManager.requestAccess { granted in
                if granted {
                    loadAndSyncContacts()
                } else {
                    self.showingPermissionDeniedAlert = true
                }
            }
        } else {
           loadAndSyncContacts()
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(contactsManager.contacts , id: \.self) { contact in
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
//                                friend.isAdded = true
                                dismiss()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title)
                            }
                        }
                    }
                }
            }
            .onAppear {
                syncContactsAndFriends()
            }
            .alert(isPresented: $showingPermissionDeniedAlert) {
                Alert(
                    title: Text("Permission Denied"),
                    message: Text("Access to contacts was denied. Please enable access in your settings if you want to sync contacts."),
                    dismissButton: .default(Text("OK")){
                        dismiss()
                    }
                )
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactList()
}
