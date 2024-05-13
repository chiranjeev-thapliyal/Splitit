//
//  FriendCard.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 14/05/24.
//

import SwiftUI

struct FriendCard: View {
    var friend: Friend
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    @AppStorage("user_id") var savedUserId: String?
    
    func addFriend(userId: String, friendId: UUID, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://wealthos.onrender.com/users/\(userId)/friends/add") else {
            completion("Invalid URL")
            return
        }
        
        // Create the payload
        let payload: [String: String] = ["id": friendId.uuidString]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            completion("Failed to encode payload")
            return
        }
        
        // Perform the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion("Network error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion("Invalid response from server")
                    return
                }
                
                if let data = data, let body = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    print(body)
                    prettyPrint(data: data)
                }
                
                switch httpResponse.statusCode {
                case 200:
                    completion("Added \(self.friend.name) to friend list")
                case 400:
                    if let data = data, let body = try? JSONDecoder().decode(ErrorResponse.self, from: data), body.reason == "Already a friend" {
                        completion("Already a friend")
                    } else {
                        completion("Bad request")
                    }
                default:
                    if let data = data, let body = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(body.reason)
                    } else {
                        completion("Bad Request: \(httpResponse.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(spacing: 8) {
                Image(friend.imageName ?? "profile4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                
                VStack(alignment: .leading) {
                    Text(friend.name)
                        .font(.subheadline)
                    Text(friend.email)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    if let userId = savedUserId {
                        addFriend(userId: userId, friendId: friend.id ) { message in
                            self.alertMessage = message
                            self.showAlert = true
                        }
                    }
                }){
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                        // Redirect or perform further actions based on the message
                        if alertMessage == "Added to friend list" {
                            // Navigate to Home or perform success action
                        }
                    }))
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Spacer()
        }
    }
}

#Preview {
    FriendCard(friend: Friend(id: UUID(), name: "Jaskaran", email: "jaskaran@gmail.com"))
}
