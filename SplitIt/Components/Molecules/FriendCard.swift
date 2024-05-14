//
//  FriendCard.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 14/05/24.
//

import SwiftUI

struct FriendCard: View {
    var friend: Friend
    var onAddFriend: (Friend) -> Void
    
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            friendInfoRow
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }

    private var friendInfoRow: some View {
        HStack(spacing: 8) {
            profileImage
            friendDetails
            Spacer()
            addButton
        }
    }

    private var profileImage: some View {
        Image(friend.imageName ?? "profile4")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }

    private var friendDetails: some View {
        VStack(alignment: .leading) {
            Text(friend.name)
                .foregroundColor(.black)
                .font(.subheadline)
            Text(friend.email)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }

    private var addButton: some View {
        Button(action: {
            onAddFriend(friend)
        }) {
            Image(systemName: "plus.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
        }
    }
}

#Preview {
    var friend = Friend(id: UUID(), name: "Jaskaran", email: "jaskaran@gmail.com")
    
    func addFriendAction(friend: Friend) {}
    
    return FriendCard(friend: friend, onAddFriend: addFriendAction)
}
