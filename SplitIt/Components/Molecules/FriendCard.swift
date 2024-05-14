//
//  FriendCard.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 14/05/24.
//

import SwiftUI

struct FriendCard: View {
    var friend: Friend
    
    @StateObject var friendModel = FriendsViewModel()
    
    @State var alertMessage = ""
    @State var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(spacing: 8) {
                Image(friend.imageName ?? "profile4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                
                VStack(alignment: .leading) {
                    Text(friend.name)
                        .font(.subheadline)
                    Text(friend.email)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                        friendModel.checkAndAddFriend(friend: friend){ success, message in
                            DispatchQueue.main.async {
                                self.alertMessage = message
                                self.showAlert = true
                            }
                        }
                }){
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Spacer()
        }
    }
}

#Preview {
    FriendCard(friend: Friend(id: UUID(), name: "Jaskaran", email: "jaskaran@gmail.com"))
}
