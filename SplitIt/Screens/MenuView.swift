//
//  MenuView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 11/04/24.
//

import SwiftUI

struct MenuView: View {
    @State var showError = false
    @State var errorMessage = ""
    
    @State var showDeleteAccount = false
    @State var deleteConfirmationText = ""
    
    @State private var isNotAuthenticated = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authentication: AuthenticationModel
    
    func deleteUser(){
        authentication.deleteUser(){ success, message in
            if success {
                if let userId = authentication.savedUserId {
                    guard let url = URL(string: "https://wealthos.onrender.com/user/\(userId)") else {
                        print("Unable to parse url")
                        return
                    }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "DELETE"
                    
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        DispatchQueue.main.async {
                            guard let httpResponse = response as? HTTPURLResponse else {
                                print("Invalid response from server")
                                return
                            }
                            
                            if httpResponse.statusCode == 200 {
                                self.authentication.logoutUser()
                            }
                                
                        }
                        
                    }.resume()
                }
            } else {
                self.errorMessage = message
                self.showError = true
            }
        }
    }
    
    private func updateAuthenticationStatus() {
        isNotAuthenticated = !authentication.isAuthenticated
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading){
                Color.darkGreen.ignoresSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    VStack {
                        NavigationLink(destination: Home()) {
                            Text("Home")
                                .font(.title)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .kerning(3)
                                .fontWeight(.thin)
                        }
                    
                        Rectangle()
                            .frame(height: 1).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    VStack {
                        Button(action: {
                            authentication.logoutUser()
                        }) {
                            Text("Logout")
                                .font(.title)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .kerning(3)
                                .fontWeight(.thin)
                        }
                    
                        Rectangle()
                            .frame(height: 1).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        NavigationLink(destination: ContentView(), isActive: $isNotAuthenticated) {
                            EmptyView()
                        }
                    }
                    .onAppear {
                        updateAuthenticationStatus()
                    }
                    .onChange(of: authentication.isAuthenticated) { isAuthenticated in
                        isNotAuthenticated = !isAuthenticated
                    }
                    
                    VStack {
                        Button(action: {
                            showDeleteAccount = true
                        }) {
                            Text("Delete Account")
                                .font(.title)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .kerning(3)
                                .fontWeight(.thin)
                        }
                    
                    }
                    
                    Spacer()
                }
                .textCase(.uppercase)
                .padding(.horizontal, 32)
                .alert("Are you sure?", isPresented: $showDeleteAccount){
                    TextField("", text: $deleteConfirmationText)
                    
                    Button("Confirm", action: {
                        if deleteConfirmationText == "DELETE" {
                            // Delete account
                            deleteUser()
                        }
                    })
                    
                    Button("Cancel", action: {
                        deleteConfirmationText = ""
                        showDeleteAccount = false
                    })
                } message: {
                    Text("Type DELETE to confirm")
                }
                    
                
                Button(action: { dismiss() }){
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.tertiaryWhite)
                        .frame(width: 24, height: 24)
                        .padding()
                }.alert(isPresented: $showError){
                    Alert(title: Text("Something went wrong"), message: Text(errorMessage), dismissButton: .cancel())
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    MenuView()
        .environmentObject(AuthenticationModel())
}
