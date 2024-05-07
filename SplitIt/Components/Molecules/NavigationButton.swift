//
//  NavigationButton.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 01/05/24.
//

import SwiftUI

struct NavigationButton<Destination: View>: View {
    let label: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination){
            Text(label)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 60)
                .background(Color.darkGreen)
                .clipShape(RoundedRectangle(cornerRadius: 24.0))
        }
    }
}

#Preview {
    NavigationButton(label: "Sign in", destination: SigninView())
}
