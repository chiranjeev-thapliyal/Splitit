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
            CircularImage(width: 60, height: 60, icon: "profile")
            
            Text(name)
                .font(.caption2)
                .foregroundStyle(Color.tertiaryWhite)
        }
    }
}

#Preview {
    FriendHome(name: "Chiranjeev Thapliyal", image: "profile")
}
