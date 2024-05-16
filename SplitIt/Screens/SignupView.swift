//
//  Signup.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

struct SignupFormData: Codable {
    let name: String
    let email: String
    let password: String
    let avatar: String
}

struct SignupView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var nameError = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    @State private var showSuccessAlert = false
    @State private var successMessage = ""
    
    @State private var showLoginScreen = false
    @State private var selectedAvatar: String = "profile"
    
    @EnvironmentObject var authentication: AuthenticationModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 20) {
                    Spacer().frame(height: 40)
                    
                    formContent
                        .padding(.horizontal, 16)
                        .alert(isPresented: $showErrorAlert) {
                            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                    
                    Spacer()
                }
                .background(LinearGradient(colors: [.darkGreen, .regularGreen, .lightGreen], startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .padding(.top, 100)
                .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    CustomNavbar(leftIconAction: { dismiss() })
                        .padding()
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .frame(height: 100)
            }
        }
        .ignoresSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(title: Text("Success"), message: Text(successMessage), dismissButton: .default(Text("OK")) {
                self.showSuccessAlert = false
                self.showLoginScreen = true
            })
        }
        
        NavigationLink(destination: SigninView(), isActive: $showLoginScreen) {
            EmptyView()
        }
    }
    
    var formContent: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                SignupTextField(
                    icon: "person",
                    placeholder: "Full Name",
                    onCommit: { nameError = validateName(fullName) },
                    onChange: { newValue in nameError = "" },
                    errorMessage: nameError,
                    text: $fullName
                )
                
                SignupTextField(
                    icon: "at",
                    placeholder: "Email",
                    onCommit: { emailError = validateEmail(email) },
                    onChange: { newValue in emailError = "" },
                    errorMessage: emailError,
                    text: $email
                )
                
                SignupTextField(
                    icon: "lock",
                    placeholder: "Password",
                    onCommit: { passwordError = validatePassword(password) },
                    onChange: { newValue in passwordError = "" },
                    errorMessage: passwordError,
                    text: $password,
                    isSecure: true
                )
                
                HStack(spacing: 16) {
                    AvatarSelectionView(selectedAvatar: $selectedAvatar)
                }
                
                
                Button("Sign up") {
                    performSignup()
                }
                .buttonStyle()
            }
        }
        .padding(.horizontal)
    }
    
    var backButton: some View {
        Button(action: { dismiss() }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.darkGreen)
        }
    }
    
    func performSignup() {
        nameError = validateName(fullName)
        emailError = validateEmail(email)
        passwordError = validatePassword(password)
        
        guard nameError.isEmpty, emailError.isEmpty, passwordError.isEmpty else {
            return
        }
        
        authentication.createUser(name: fullName, email: email, password: password) { success, message in
            if success {
                let formData = SignupFormData(name: fullName, email: email, password: password, avatar: selectedAvatar)
                submitSignupForm(data: formData) { success, message in
                    if success {
                        DispatchQueue.main.async {
                            successMessage = message
                            showSuccessAlert = true
                        }
                    } else {
                        authentication.deleteUser() { success, message in
                            DispatchQueue.main.async {
                                errorMessage = "Please try again."
                                showErrorAlert = true
                            }
                        }
                        
                    }
                }
            } else {
                DispatchQueue.main.async {
                    errorMessage = message
                    showErrorAlert = true
                }
            }
        }
    }
    
    func submitSignupForm(data: SignupFormData, completionHandler: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "https://wealthos.onrender.com/user") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(data)
        } catch {
            print("Failed to encode formData")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completionHandler(false, "Invalid response from server")
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        authentication.savedEmail = loginResponse.email
                        completionHandler(true, "User created successfully.")
                    }
                } catch {
                    completionHandler(false, "Failed to decode the response")
                }
            } else {
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    completionHandler(false, errorResponse.reason)
                } else {
                    completionHandler(false, "An unknown error occurred.")
                }
            }
        }.resume()
    }
    
    func validateName(_ name: String) -> String {
        name.isEmpty ? "Enter a valid name" : ""
    }
    
    func validateEmail(_ email: String) -> String {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email) ? "" : "Enter valid email"
    }
    
    func validatePassword(_ password: String) -> String {
        password.count >= 6 ? "" : "Password should be more than 6 characters"
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(Color.darkGreen)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .fontWeight(.light)
            .padding(.horizontal)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonStyle())
    }
}

#Preview {
    SignupView()
        .environmentObject(AuthenticationModel())
}
