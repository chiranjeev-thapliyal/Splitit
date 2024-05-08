//
//  MenuOption.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 08/05/24.
//

import SwiftUI

struct MenuOption: View {
    let icon: String
    let text: String
    var action: () -> Void

    var body: some View {
        HStack(alignment: .center ,spacing: 12) {
            Spacer()
            
            Text(text)
                .fontWeight(.medium)
                .foregroundStyle(Color.darkGreen)
                .kerning(1)

            Image(systemName: icon)
                .font(.system(size: 24))
                .frame(width: 40, height: 40)
                .background(Color.regularGreen)
                .foregroundColor(.tertiaryWhite)
                .clipShape(Circle())

        }
        .padding(.horizontal, 8)
        .clipShape(Capsule())
        .shadow(radius: 5)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    MenuOption(icon: "doc.text", text: "Add Friend", action: { print("Add Friend selected") })
}
