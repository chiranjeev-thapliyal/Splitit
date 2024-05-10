//
//  FriendsList.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import SwiftUI

struct FriendsList: View {
    var title = ""
    var friendsList: [Friend] = []
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .textCase(.uppercase)
                .font(.subheadline)
                .kerning(1)
                .foregroundStyle(Color.tertiaryWhite)
                .padding(.top, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(friendsList, id: \.self){friend in
                        NavigationLink(destination: NewTransactionView(friend: friend)){
                            FriendHome(name: shortenFullName(friend.name) , image: friend.imageName ?? "profile")
                        }
                        
                    }
                }
                .padding(.horizontal, 8) // Add horizontal padding to the card
                .padding(.vertical, 12)
            }
            
        }
    }
}


#Preview {
    FriendsList()
}
