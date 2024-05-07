//
//  Signup.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct SignupFormData: Codable {
    let name: String
    let phoneNumber: String
    let email: String
    let password: String
}

struct SignupView: View {
    
    @AppStorage("user_id") var savedUserId: String?
    @AppStorage("token") var savedToken: String?
    @AppStorage("name") var savedName: String?
    @AppStorage("email") var savedEmail: String?
    
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var currency: String = ""
    
    @State private var nameError = ""
    @State private var phoneNumberError = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    func submitSignupForm(data: SignupFormData, completionHandler: @escaping (Bool, String) -> Void){
        do {
            let url = URL(string: "https://wealthos.onrender.com/user")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(data)
            
            // Send the information inside req.body
            URLSession.shared.dataTask(with: request){ data, response, error in
                DispatchQueue.main.async {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completionHandler(false, "Invalid response from server")
                        return
                    }
                    
                    if httpResponse.statusCode == 200, let data = data {
                        do {
                            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                            self.savedUserId = loginResponse.id
                            self.savedToken = loginResponse.token
                            self.savedName = loginResponse.name
                            self.savedEmail = loginResponse.email
                            
                            completionHandler(true, "User created successfully.")
                        } catch {
                            completionHandler(false, "Failed to decode the response")
                        }
                        return
                    }
                    
                    if let data = data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completionHandler(false, errorResponse.reason)
                    } else {
                        completionHandler(false, "An unknown error occurred.")
                    }
                }
            }.resume()
        } catch {
            print("Failed to encode formData")
        }
        
    }
    
    func validateName(_ name: String) -> String {
        if name.count > 0 {
            return ""
        }
        
        return "Enter a valid name"
    }
    
    func validatePhoneNumber(_ phoneNumber: String) -> String {
        if !(phoneNumber.count == 10){
            return "Enter 10 digit mobile number"
        }
        
        return ""
    }
    
    func validateEmail(_ email: String) -> String {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        if !emailPredicate.evaluate(with: email){
            return "Enter valid email"
        }
        
        return ""
    }
    
    func validatePassword(_ password: String) -> String {
        if password.count < 6 {
            return "Password should be more than 6 characters"
        }
        
        return ""
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                VStack(spacing: 20) {
                    Spacer().frame(height: 40)
                    
                    Group {
                        SignupTextField(
                            icon: "person",
                            placeholder: "Full Name",
                            onCommit: { nameError = validateName(fullName) },
                            onChange: { newValue in
                                nameError = ""
                            },
                            errorMessage: nameError,
                            text: $fullName
                        )
                        
                        SignupTextField(
                            icon: "phone",
                            placeholder: "Phone Number",
                            keyboardType: .numberPad,
                            onCommit: { phoneNumberError = validatePhoneNumber(phoneNumber) },
                            onChange: { newValue in 
                                phoneNumber = newValue.filter{ $0.isNumber }
                                phoneNumberError = ""
                            },
                            errorMessage: phoneNumberError,
                            text: $phoneNumber
                        )
                        
                        SignupTextField(
                            icon: "at",
                            placeholder: "Email",
                            onCommit: { emailError = validateEmail(email) },
                            onChange: { newValue in
                                emailError = ""
                            },
                            errorMessage: emailError, 
                            text: $email
                        )
                        
                        SignupTextField(
                            icon: "lock",
                            placeholder: "Password",
                            onCommit: { passwordError = validatePassword(password) },
                            onChange: { newValue in
                                passwordError = ""
                            },
                            errorMessage: passwordError,
                            text: $password, 
                            isSecure: true
                        )
                        
                        Button(action: {
                            nameError = validateName(fullName)
                            phoneNumberError = validatePhoneNumber(phoneNumber)
                            emailError = validateEmail(email)
                            passwordError = validatePassword(password)
                            
                            if !(nameError.isEmpty && phoneNumberError.isEmpty && emailError.isEmpty && passwordError.isEmpty) {
                                return
                            }
                            
                            let formData = SignupFormData(name: fullName, phoneNumber: phoneNumber, email: email, password: password)
                            
                            submitSignupForm(data: formData){ success, message in
                                if !success {
                                    self.errorMessage = message
                                    self.showErrorAlert = true
                                }
                            }
                        }) {
                            Text("Sign up")
                                .padding(.horizontal, 32)
                                .padding(.vertical, 16)
                                .background(Color.darkGreen)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .fontWeight(.light)
                            
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal, 16)
                    .alert(isPresented: $showErrorAlert) {
                        Alert(title: Text(errorMessage), message: Text("Retry with valid details"), dismissButton: .default(Text("OK")))
                    }
                    
                    Spacer()
                }
                .background(LinearGradient(colors: [.darkGreen, .regularGreen, .lightGreen], startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .padding(.top, 100) // Adjust this padding to control where the bottom sheet starts.
                .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    HStack {
                        BackButton(action: { dismiss()})
                        Spacer()
                        HeaderTitle(first: "wealth", second: "OS")
                            .font(.largeTitle)
                            .fontWeight(.thin)
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SignupView()
}
