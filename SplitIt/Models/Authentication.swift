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
    
    func loginUser(email: String, password: String, completionHandler: @escaping (Bool, String, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
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
