//
//  CircularImageWithAction.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 08/05/24.
//

import SwiftUI

struct CircularImageWithAction: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Profile Image
            Circle()
                .strokeBorder(Color.tertiaryWhite, lineWidth: 4)
                .overlay(
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .padding(4)
                )
                .frame(width: 100, height: 100)
            
            
            // Profile Add(+) Button
            Circle()
                .fill(Color.darkGreen)
//                .overlay(
//                    Image(systemName: "plus") // System image
//                        .foregroundColor(Color.tertiaryWhite)
//                )
                .frame(width: 0, height: 0)
                .offset(x: 0, y: 0)
        }
    }
}

#Preview {
    CircularImageWithAction()
}
