//
//  Signup.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct SignupView: View {
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var currency: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                VStack(spacing: 20) {
                    Spacer().frame(height: 40)
                    
                    Group {
                        SignupTextField(icon: "person", placeholder: "Full Name", text: $fullName)
                        SignupTextField(icon: "phone", placeholder: "Phone Number", text: $phoneNumber)
                        SignupTextField(icon: "at", placeholder: "Email", text: $email)
                        SignupTextField(icon: "lock", placeholder: "Password", text: $password)
                        SignupTextField(icon: "dollarsign", placeholder: "Currency", text: $currency)
                        
                        Button(action: {
                            
                        }) {
                            Text("Signup")
                                .frame(maxWidth: 240)
                                .padding()
                                .background(Color.darkGreen)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        }.padding(.horizontal)
                        
                    }.padding(.horizontal, 16)
                    
                    Spacer()
                }
                .background(LinearGradient(colors: [.darkGreen, .regularGreen, .lightGreen], startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .padding(.top, 100) // Adjust this padding to control where the bottom sheet starts.
                .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    HStack {
                        backButton
                        Spacer()
                        SplitwiseTextView()
                        Spacer()
                    }
                    .padding()
                    .background(Color.tertiaryWhite) // Ensure this matches your app's theme
                    .foregroundColor(.black)
                    
                    Spacer() // This pushes the top bar to the top
                }
                .frame(height: 100)
                .background(Color.tertiaryWhite)
                
            }.background(Color.tertiaryWhite)
            
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
        .background(Color.tertiaryWhite)
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
            }) {
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
    SignupView()
}
