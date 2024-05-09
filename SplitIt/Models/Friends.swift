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
    var phoneNumber: String?
    var imageName: String?
}

class FriendsViewModel: ObservableObject {
    @AppStorage("user_id") var savedUserId: String?
    
    @Published var friends: [Friend] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let session = URLSession.shared
    
    func checkAndAddFriend(friend: Friend) {
        let userId = friend.phoneNumber // Assuming phone number can uniquely identify a user

        getUser(userId: userId) { [weak self] existingUser in
            if let user = existingUser {
                // Friend is already a user, add as friend
                self?.addFriend(userId: user.userId)
            } else {
                // Friend is not a user, create new user
                self?.createUser(friend: friend) { newUser in
                    self?.addFriend(userId: newUser.userId)
                }
            }
        }
    }
    
    private func getUser(userId: String, completion: @escaping (User?) -> Void) {
            let url = URL(string: "https://wealthos.onrender.com//user/\(userId)")!
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to fetch user: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }

                let user = try? JSONDecoder().decode(User.self, from: data)
                completion(user)
            }
            task.resume()
        }

        private func addFriend(userId: String) {
            let url = URL(string: "https://your.api.endpoint/users/\(userId)/friends/add")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error adding friend: \(error.localizedDescription)")
                    return
                }
                print("Friend added successfully")
            }
            task.resume()
        }

        private func createUser(friend: Friend, completion: @escaping (User) -> Void) {
            let url = URL(string: "https://your.api.endpoint/user")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(friend)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to create user: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                if let newUser = try? JSONDecoder().decode(User.self, from: data) {
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
    
    func addFriend(_ newFriend: Friend) {
        if let userId = savedUserId {
            // Check if newFriend is already a user
            
            // If a user, then directly map with user
            
            // If not a user, then create a new user and map it
            
            let url = URL(string: "https://wealthos.onrender.com/user/\(userId)/friends/add")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // Check if user exists in the database
            
            
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
