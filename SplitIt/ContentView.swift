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
                    Button(action: {
                           // Signup action
                       }) {
                           Text("Sign in")
                               .foregroundColor(.white)
                               .padding()
                               .frame(maxWidth: .infinity)
                               .background(Color.primaryGreen)
                               .cornerRadius(10)
                       }
                    NavigationLink(destination: SignupView()){
                        Text("Sign up")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryGreen)
                            .cornerRadius(10)
                    }
                }
                .font(.custom("Rubik-Thin", size: 20))
                .padding(.horizontal, 40)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
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
            Text("Wealth").foregroundColor(.primaryGreen)
            Text("OS").foregroundColor(.gray)
        }.font(.custom("Rubik-Regular", size: 48))
    }
}
