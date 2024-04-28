//
//  ContentView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                SplitwiseTextView()
                
                VStack {
                    NavigationLink(destination: SigninView()){
                           Text("Sign in")
                               .foregroundColor(.white)
                               .padding(.vertical, 12)
                               .padding(.horizontal, 60)
                               .background(Color.darkGreen)
                               .clipShape(RoundedRectangle(cornerRadius: 25.0))
                       }
                    NavigationLink(destination: SignupView()){
                        Text("Sign up")
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 60)
                            .background(Color.darkGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                }
                .font(.custom("Rubik-Light", size: 20))
                .padding(.horizontal, 40)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.tertiaryWhite)
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}

struct SplitwiseTextView: View {
    var body: some View {
        HStack(spacing: 0){
            Text("Wealth").foregroundColor(.darkGreen)
            Text("OS").foregroundColor(.gray)
        }.font(.custom("Rubik-Light", size: 48))
    }
}
