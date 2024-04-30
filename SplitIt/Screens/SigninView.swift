//
//  SigninView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct SigninView: View {
    @State var email: String = ""
    @State var password: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                    VStack {
                        Spacer().frame(height: 40)
                        
                        Group {
                            SignupTextField(icon: "at", placeholder: "Email", text: $email)
                            SignupTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                            
                            Spacer().frame(height: 40)
                            
                            NavigationLink (destination: Home()) {
                                Text("Sign in")
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 32)
                                    .background(Color.darkGreen)
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .fontWeight(.light)
                                    
                                    
                            }
                        }.padding(.horizontal, 16)
                        
                        
                        Spacer()
                    }
                    .background(LinearGradient(colors: [.darkGreen, .regularGreen, .lightGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .padding(.top, 100)
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    HStack {
                        BackButton(action: { dismiss() })
                        Spacer()
                        HeaderTitle(first: "wealth", second: "OS")
                            .font(.largeTitle)
                            .fontWeight(.thin)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.tertiaryWhite) // Ensure this matches your app's theme
                    .foregroundColor(.black)
                    
                    Spacer()
                }.frame(height: 100)
                
            }
            .background(Color.tertiaryWhite)
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
        .background(Color.tertiaryWhite)
        
    }
}

#Preview {
    SigninView()
}
