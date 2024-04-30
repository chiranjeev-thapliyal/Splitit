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
                HeaderTitle(first: "wealth", second: "OS").font(.system(size: 56)).kerning(2).fontWeight(.thin)
                
                VStack {
                    NavigationLink(destination: SigninView()){
                           Text("Sign in")
                               .foregroundColor(.white)
                               .padding(.vertical, 12)
                               .padding(.horizontal, 60)
                               .background(Color.darkGreen)
                               .clipShape(RoundedRectangle(cornerRadius: 24.0))
                       }
                    NavigationLink(destination: SignupView()){
                        Text("Sign up")
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 60)
                            .background(Color.darkGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    }
                }
                .font(.headline)
                .kerning(1)
                .fontWeight(.light)
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

