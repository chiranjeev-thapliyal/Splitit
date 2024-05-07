//
//  FriendsList.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import SwiftUI

struct GroupsList: View {
    var title = ""
    var groupsList: [UserGroup] = []
    
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
                    ForEach(groupsList, id: \.self){group in
                        NavigationLink(destination: {}) {
                            GroupHome(name: group.name)
                        }
                        
                    }
                }
                .padding(.horizontal, 8) // Add horizontal padding to the card
                .padding(.vertical, 8)
            }
            
        }
    }
}


#Preview {
    GroupsList()
}
