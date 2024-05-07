//
//  GroupHome.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import SwiftUI

struct GroupHome: View {
    let name: String
    
    var body: some View {
        VStack{
            CircularImage(width: 60, height: 60, icon: "group1")
            
            Text(name)
                .font(.caption2)
                .foregroundStyle(Color.tertiaryWhite)
        }
    }
}

#Preview {
    GroupHome(name: "Udupi")
}
