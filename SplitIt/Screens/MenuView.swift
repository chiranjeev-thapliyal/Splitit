//
//  MenuView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 11/04/24.
//

import SwiftUI

struct MenuView: View {
    @AppStorage("token") var savedToken: String?
    @AppStorage("user_id") var savedUserId: String?
    
    @State var showDeleteAccount = false
    @State var deleteConfirmationText = ""
    
    @Environment(\.dismiss) var dismiss
    
    func deleteUser(){
        if let userId = savedUserId {
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
                    
                    print("httpResponse", httpResponse)
                    if httpResponse.statusCode == 200 {
                        savedToken = ""
                        savedUserId = ""
                    }
                        
                }
                
            }.resume()
        }
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
                            self.savedToken = ""
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
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    MenuView()
}
