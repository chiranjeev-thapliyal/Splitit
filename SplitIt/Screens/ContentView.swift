//
//  ContentView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authentication: AuthenticationModel
    @State private var isActive: Bool = true
    
    var body: some View {
        NavigationStack {
            if isActive {
                NavigationLink(destination: Home(), isActive: $isActive) {
                    EmptyView()
                }
                
            } else {
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
            }
        }
        .onAppear {
            authentication.checkIsAuthenticated()
        }
        .onReceive(authentication.$isAuthenticated) { isAuthenticated in
            if !isAuthenticated {
                self.isActive = false
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationModel())
}



