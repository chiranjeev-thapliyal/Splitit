//
//  Friends.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import Foundation
import SwiftUI

struct Friend: Codable, Hashable {
    var id: String
    var name: String
    var email: String?
//    var phoneNumber: String?
    var imageName: String?
}

class FriendsViewModel: ObservableObject {
    @AppStorage("user_id") var savedUserId: String?
    
    @Published var friends: [Friend] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let session = URLSession.shared
    
    func checkAndAddContact(contact: Contact) {
        let email = lastTenDigits(of: contact.email)

        if let userId = savedUserId {
            getUser(email: email) { [weak self] existingUser in
                if let existingUser = existingUser {
                    // Friend is already a user, add as friend
                    self?.addFriend(userId: userId, friendId: existingUser.id)
                } else {
                    // Friend is not a user, create new user
                    self?.createUser(contact: contact) { newUser in
                        self?.addFriend(userId: userId, friendId: newUser.id)
                    }
                }
            }
        }
    }
    
    private func getUser(email: String, completion: @escaping (TemporaryUser?) -> Void) {
        let url = URL(string: "https://wealthos.onrender.com/user/email/\(email)")!
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let user = try? JSONDecoder().decode(TemporaryUser.self, from: data)
            completion(user)
        }
        task.resume()
    }

    private func addFriend(userId: String, friendId: UUID) {
        let url = URL(string: "https://wealthos.onrender.com/users/\(userId)/friends/add")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(["id": friendId])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return
            }
            
            do {
                if let data = data {
                    let newFriend = try JSONDecoder().decode(TemporaryUser.self, from: data)
                    print("newFriend", newFriend)
//                    self.friends.append(newFriend)
                }
            } catch {
                print("Error while decoding newFriend")
            }
           
        }
        task.resume()
    }

    private func createUser(contact: Contact, completion: @escaping (TemporaryUser) -> Void) {
        let url = URL(string: "https://wealthos.onrender.com/user/temporary")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(contact)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to create user: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let newUser = try? JSONDecoder().decode(TemporaryUser.self, from: data) {
                completion(newUser)
            }
        }
        task.resume()
    }

    func getFriends() {
        isLoading = true
        errorMessage = nil
        
        if let userId = savedUserId {
            let url = URL(string: "https://wealthos.onrender.com/user/\(userId)/friends")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    guard let data = data, error == nil else {
                        self?.errorMessage = "Failed to load friends: \(error?.localizedDescription ?? "Unknown error")"
                        return
                    }
                    
                    do {
                        self?.friends = try JSONDecoder().decode([Friend].self, from: data)
                    } catch {
                        self?.errorMessage = "Failed to decode friends data"
                    }
                }
            }.resume()
        }
        
        
    }
}
