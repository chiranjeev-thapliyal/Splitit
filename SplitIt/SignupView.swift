//
//  Signup.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct SignupFormData: Codable {
    let fullName: String
    let phoneNumber: String
    let email: String
    let password: String
    let currency: String
}

struct SignupView: View {
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var currency: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    func submitSignupForm(data: SignupFormData){
        guard let url = URL(string: "http://127.0.0.1:8080/user/register") else {
            print("Unable to parse url")
            return
        }
        
        
        
        // Create a http request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do {
             let payload = try JSONEncoder().encode(data)
            
            request.httpBody = payload
            
            // Send the information inside req.body
            URLSession.shared.dataTask(with: request){ data, response, error in
                if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("response: \(responseString)")
                    }
                } else if let error = error {
                    print("http request failed \(error)")
                }
                
            }.resume()
        } catch {
            print("Failed to encode formData")
        }
        
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                VStack(spacing: 20) {
                    Spacer().frame(height: 40)
                    
                    Group {
                        SignupTextField(icon: "person", placeholder: "Full Name", text: $fullName)
                        SignupTextField(icon: "phone", placeholder: "Phone Number", text: $phoneNumber)
                        SignupTextField(icon: "at", placeholder: "Email", text: $email)
                        SignupTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                        SignupTextField(icon: "dollarsign", placeholder: "Currency", text: $currency)
                        
                        Button(action: {
                            // Gather information
                            let formData = SignupFormData(fullName: fullName, phoneNumber: phoneNumber, email: email, password: password, currency: currency)
                            
                            submitSignupForm(data: formData)
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
