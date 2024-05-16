//
//  HeaderTitle.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 29/04/24.
//

import SwiftUI

struct HeaderTitle: View {
    let first: String
    let second: String
    
    var body: some View {
        HStack(spacing: 0){
            Text(first)
                .foregroundStyle(LinearGradient(colors: [.darkGreen, .lightGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: Color.green.opacity(0.5), radius: 3, x: 2, y: 2)

            
            Text(second)
                .foregroundColor(.gray)
                .shadow(color: Color.gray.opacity(0.2), radius: 1, x: 0, y: 1)
                .offset(x: 1, y: 1)
                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 2, y: 2) //
        }
    }
}

#Preview {
    HeaderTitle(first: "wealth", second: "OS")
}
