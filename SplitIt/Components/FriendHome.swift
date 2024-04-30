//
//  FriendHome.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 30/04/24.
//

import SwiftUI

struct FriendHome: View {
    let name: String
    let image: String
    
    var body: some View {
        VStack{
            Circle()
                .strokeBorder(Color.tertiaryWhite, lineWidth: 4)
                .overlay(
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                ).frame(width: 60, height: 60)
            
            Text(name)
                .font(.caption2)
                .foregroundStyle(Color.tertiaryWhite)
        }
    }
}

#Preview {
    FriendHome(name: "Chiranjeev Thapliyal", image: "profile")
}
