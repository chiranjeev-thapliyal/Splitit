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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 20) {
                    SignupTextField(icon: "person", placeholder: "Full Name", text: $fullName)
                    SignupTextField(icon: "phone", placeholder: "Phone Number", text: $phoneNumber)
                    SignupTextField(icon: "at", placeholder: "Email", text: $email)
                    SignupTextField(icon: "lock", placeholder: "Password", text: $password)
                    SignupTextField(icon: "dollarsign", placeholder: "Currency", text: $currency)
                }
                
                
                Spacer()
            }
            .padding()
            .background(.green)
        }
        .background(.white)
        .ignoresSafeArea(.all)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: 
            HStack{
                backButton
                Spacer()
                SplitwiseTextView()
                Spacer()
            }
            .background(.white)
            .edgesIgnoringSafeArea(.all)
        )
    }
    
    private var backButton: some View {
        Button(action: {
                
            }) {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.green)
                    .padding(10)
                    .background(.white)
                    .overlay(Circle().stroke(Color.green, lineWidth: 2))
                    .clipShape(Circle())
            }
        
    }
}

#Preview {
    SignupView()
}
