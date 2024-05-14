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
    @State private var showError: Bool = false
    @State private var error: String = ""
    @State private var errorMessage: String = ""
    @State private var showSuccess: Bool = false
    @State private var successMessage: String = ""
    @State private var isAuthenticated: Bool = false
    @State var showSignup: Bool = false
    
    @AppStorage("user_id") var savedUserId: String?
    @AppStorage("token") var savedToken: String?
    @AppStorage("name") var savedName: String?
    @AppStorage("email") var savedEmail: String?
    
    @StateObject var authentication = AuthenticationModel()
    
    @Environment(\.dismiss) var dismiss
    
    func login(email: String, password: String) {
        guard let url = URL(string: "https://wealthos.onrender.com/user/login") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        do {
            let payload = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = payload
        } catch {
            print("Error serializing payload: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.error = "Client error: \(error.localizedDescription)"
                    self.showError = true
                    return
                }
                
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode != 200, let data = data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        self.error = "\(errorResponse.reason)"
                        self.showError = true
                    }
                }
                
                if let data = data {
                    do {
                        let responseData = try JSONDecoder().decode(LoginResponse.self, from: data)
                        savedUserId = responseData.id
                        savedToken = responseData.token
                        savedName = responseData.name
                        savedEmail = responseData.email
                        isAuthenticated = true
                    } catch {
                        print("Error in decoding response data")
                        return
                    }
                }
            }
        }
        task.resume()
    }

    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                    VStack {
                        Spacer().frame(height: 40)
                        
                        Group {
                            SignupTextField(icon: "at", placeholder: "Email", text: $email)
                            SignupTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                            
                            Spacer().frame(height: 40)
                            
                            Button(action: {
                                authentication.loginUser(email: email, password: password){ success, error, message in
                                    if !success {
                                        self.errorMessage = message
                                        self.error = error
                                        self.showError = true
                                    } else {
                                        login(email: self.email, password: self.password)
                                    }
                                }}){
                                Text("Sign in")
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.darkGreen)
                            .foregroundStyle(Color.tertiaryWhite)
                            .font(.headline)
                            .kerning(1)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .alert(isPresented: $showSuccess){
                                Alert(title: Text(successMessage), dismissButton: .default(Text("Ok")){
                                    self.showSuccess = false
                                    self.successMessage = ""
                                })
                            }
                            .alert(isPresented: $showError){
                                if error == "Email is not verified yet" {
                                    return Alert(
                                        title: Text("Email Verification Needed"),
                                        message: Text(errorMessage),
                                        primaryButton: .default(Text("Resend Link"), action: {
                                            // Call the function to resend the verification email
                                            authentication.resendVerificationEmail(){ success, error in
                                                if !success {
                                                    self.error = error
                                                    self.showError = true
                                                } else {
                                                    self.successMessage = "Verification link sent!"
                                                    self.showSuccess = true
                                                }
                                            }
                                        }),
                                        secondaryButton: .cancel({
                                            // Simply dismiss the alert
                                            self.showError = false
                                        })
                                    )
                                } else if error == "User doesn't exists" {
                                    return Alert(
                                        title: Text(error),
                                        message: Text("Seems like you don't have an account with us. You create one now!"),
                                        primaryButton: .default(Text("Sign up"), action: {
                                            showSignup = true
                                        }),
                                        secondaryButton: .cancel({
                                            self.showError = false
                                        })
                                    )
                                } else {
                                    return Alert(
                                        title: Text(error),
                                        dismissButton: .cancel() {
                                            self.showError = false
                                        }
                                    )
                                }
                            }
                            
                        }.padding(.horizontal, 16)
                        
                        
                        Spacer()
                    }
                    .background(LinearGradient(colors: [.darkGreen, .regularGreen, .lightGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .padding(.top, 100)
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    CustomNavbar(leftIconAction: { dismiss() })
                        .padding()
                        .background(Color.tertiaryWhite) // Ensure this matches your app's theme
                        .foregroundColor(.black)
                    
                    Spacer()
                }.frame(height: 100)
                
                NavigationLink(destination: Home(), isActive: $isAuthenticated){
                    EmptyView()
                }
                
                NavigationLink(destination: SignupView(), isActive: $showSignup) {
                    EmptyView()
                }
                
            }
            .background(Color.tertiaryWhite)
        }
        .ignoresSafeArea(.all)
        .background(Color.tertiaryWhite)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left") // Icon
                        Text("Back") // Text
                    }
                    .foregroundColor(Color.darkGreen) // Custom color
                }
            }
        }
        
    }
}

#Preview {
    SigninView()
}
