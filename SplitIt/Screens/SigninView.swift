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
    @State private var isAuthenticated: Bool = false
    
    @AppStorage("user_id") var savedUserId: String?
    @AppStorage("token") var savedToken: String?
    @AppStorage("name") var savedName: String?
    @AppStorage("email") var savedEmail: String?
    
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
                    if httpResponse.statusCode != 200 {
                        self.error = "Server error: \(httpResponse.statusCode)"
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
                                login(email: email, password: password)
                            }){
                                Text("Sign in")
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.darkGreen)
                            .foregroundStyle(Color.tertiaryWhite)
                            .font(.headline)
                            .kerning(1)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            
                            
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
                
//                NavigationLink(destination: Home(), isActive: $isAuthenticated){
//                    EmptyView()
//                }
                
            }
            .background(Color.tertiaryWhite)
        }
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
        .background(Color.tertiaryWhite)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

#Preview {
    SigninView()
}
