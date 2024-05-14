//
//  Authentication.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 03/05/24.
//

import Foundation
import SwiftUI
import Firebase

struct LoginCredentials: Codable, Hashable {
    let email: String
    let password: String
}

struct LoginResponse: Codable, Hashable {
    let id: String
    let token: String
    let email: String
    let name: String
}

class AuthenticationModel: ObservableObject {
    @AppStorage("user_id") var savedUserId: String?
    @AppStorage("token") var savedToken: String?
    @AppStorage("name") var savedName: String?
    @AppStorage("email") var savedEmail: String?
    
    @Published var isAuthenticated = false {
        didSet {
            if !isAuthenticated {
                logoutUser()
            }
        }
    }
    
    func logoutUser(){
        savedName = ""
        savedToken = ""
        savedEmail = ""
        savedUserId = ""
    }
    
    func checkIsAuthenticated() {
        if let userId = savedUserId, let userToken = savedToken, let userName = savedName, let userEmail = savedEmail {
            if !(userId.isEmpty || userToken.isEmpty || userName.isEmpty || userEmail.isEmpty) {
                isAuthenticated = isValidUser()
            } else {
                isAuthenticated = false
            }
        } else {
            isAuthenticated = false
        }
    }
    
    func isValidUser() -> Bool {
        var result = false
        
        guard let userEmail = savedEmail else {
            return false
        }
        
        guard let url = URL(string: "https://wealthos.onrender.com/user/email/\(userEmail)") else {
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let _ = error {
                    result = false
                    return
                }
                
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    if httpResponse.statusCode != 200 {
                        result = false
                        return
                    }
                }
                
                if let data = data {
                    do {
                        let _ = try JSONDecoder().decode(LoginResponse.self, from: data)
                        result = true
                    } catch {
                        result = false
                        return
                    }
                }
            }
        }
        
        task.resume()
       
        return result
    }
    
    func deleteUser(completionHandler: @escaping (Bool, String) -> Void) {
        // Check if there is a user logged in
        guard let user = Auth.auth().currentUser else {
            completionHandler(false, "No user is logged in.")
            return
        }

        // Proceed to delete the user
        user.delete { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                    completionHandler(false, error.localizedDescription)
                } else {
                    completionHandler(true, "User successfully deleted.")
                }
            }
        }
    }
    
    func loginUser(email: String, password: String, completionHandler: @escaping (Bool, String, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let _ = self else { return }
            
            if let error = error {
                completionHandler(false, "User doesn't exists", error.localizedDescription)
                return
            }

            if let user = Auth.auth().currentUser {
                if user.isEmailVerified {
                    // Email is verified, proceed
                    completionHandler(true, "" ,"User successfully logged in.")
                } else {
                    // Email is not verified, request to verify
//                    self.resendVerificationEmail()
                    completionHandler(false, "Email is not verified yet" , "Please try resending message if you haven't received it yet")
                }
            }
        }
    }

    func createUser(name: String, email: String, password: String, completionHandler: @escaping (Bool, String) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionHandler(false, error.localizedDescription)
                return
            }

            if let user = authResult?.user {
                // User was created, now update the profile with the display name
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name  // 'name' is the name you want to store
                changeRequest.commitChanges { error in
                    if let error = error {
                        completionHandler(false, error.localizedDescription)
                    } else {
                        // Profile updated, now send a verification email
                        user.sendEmailVerification { error in
                            if let error = error {
                                completionHandler(false, error.localizedDescription)
                            } else {
                                completionHandler(true, "Please check your inbox for verification email")
                            }
                        }
                    }
                }
            }
        }

    }
    
    func checkUserStatus(){
        if let user = Auth.auth().currentUser {
            if user.isEmailVerified {
                // Email is verified, proceed
            } else {
                // Email is not verified, show a message or resend verification email
            }
        }
    }
    
    func resendVerificationEmail(completionHandler: @escaping (Bool, String) -> Void){
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if let error = error {
                completionHandler(false, error.localizedDescription)
            } else {
                completionHandler(true, "Verification email sent")
            }
        })
    }
    
}
