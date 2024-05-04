//
//  ContentView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("token") var token: String?
    
    var body: some View {
        if token != nil && !token!.isEmpty {
            Home()
        } else {
            NavigationStack {
                VStack(spacing: 20) {
                    HeaderTitle(first: "wealth", second: "OS").font(.system(size: 56)).kerning(2).fontWeight(.thin)
                    
                    VStack {
                        NavigationButton(label: "Sign in", destination: SigninView())
                        NavigationButton(label: "Sign up", destination: SignupView())
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
}

#Preview {
    ContentView()
}



