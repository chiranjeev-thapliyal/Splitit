//
//  BackButton.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 29/04/24.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.darkGreen)
                .padding(10)
                .background(Color.tertiaryWhite)
                .overlay(Circle().stroke(Color.darkGreen, lineWidth: 2))
                .clipShape(Circle())
        }
        
    }
}

#Preview {
    BackButton(action: {
        print("Back Button Pressed")
    })
}
