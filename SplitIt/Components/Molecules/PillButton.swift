//
//  PillButton.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 08/05/24.
//

import SwiftUI

struct PillButton: View {
    let icon: String
    let label: String
    let color: Color
    let action: () -> Void
    private let buttonWidth: CGFloat = 180  // You can adjust this width based on your UI design


    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(label)
            }
            .padding()
            .frame(width: buttonWidth, alignment: .center)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(20)
        }
    }
}

#Preview {
    PillButton(icon: "person.badge.plus", label: "Add Friend", color: .blue, action: {})
}
