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
    @StateObject var friends = FriendsViewModel()
    
    @Environment(\.dismiss) var dismiss

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

                        if true {
                            Button(action: {
//                                friend.isAdded = true
                                dismiss()  // Dismiss the list view after adding a friend
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
                contactsManager.requestAccess()
            }
            .navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactList()
}
