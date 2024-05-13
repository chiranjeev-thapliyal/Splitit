//
//  AddFriend.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 14/05/24.
//

import SwiftUI

struct FriendSearchView: View {
    @State private var friendEmail = ""
    @State private var showDetails = false
    @State private var showNotFoundAlert = false
    @State private var tempFriendName = ""
    @State private var foundFriend: Friend?
    
    func searchFriendByEmail(email: String, completion: @escaping (Bool, String) -> Void) {
        guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://wealthos.onrender.com/user/email/\(encodedEmail)") else {
            completion(false, "Please enter valid email")
            return
        }

        // Create a URL request object
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Start a URLSession data task to fetch data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                // Handle potential errors in the request
                if let _ = error {
                    completion(false, "Something went wrong")
                    return
                }

                // Check the response code and parse the data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let data = data else {
                    completion(false, "Something went wrong, we're checking it.")
                    return
                }

                // Decode the JSON data into the Friend struct
                do {
                    let friend = try JSONDecoder().decode(Friend.self, from: data)
                    foundFriend = friend
                    completion(true, "We found your friend")
                } catch {
                    completion(false, "We're checking what went wrong")
                }
            }
        }

        // Start the network task
        task.resume()
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Text("Search Friend")
                    .font(.largeTitle)
                    .kerning(1)
                    .bold()
                    .foregroundStyle(Color.darkGreen)
                
                TextField("Enter friend's email", text: $friendEmail)
                    .padding()
                    .cornerRadius(25)
                    .background(Color.tertiaryWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .foregroundColor(Color.black.opacity(0.8))
                    
                
                Button("Search Friend") {
                    searchFriendByEmail(email: friendEmail){ success, message in
                        if !success {
                            showNotFoundAlert = true
                        } else {
                            showDetails = true
                        }
                    }
                }
                .padding()
                .kerning(1)
                .foregroundColor(.white)
                .background(Color.darkGreen)
                .clipShape(Capsule())
                
                if let friend = foundFriend {
                    FriendCard(friend: friend)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .alert("User not found", isPresented: $showNotFoundAlert) {
                TextField("Enter name for temporary user", text: $tempFriendName)
                Button("Continue", action: createTempUser)
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("You can continue by providing a name for this new friend.")
            }
        }
    }
    
    func createTempUser() {
        foundFriend = Friend(id: UUID(), name: tempFriendName, email: friendEmail, imageName: "profile\(Int.random(in: 2...5))")
        showNotFoundAlert = false
    }
}

#Preview {
    FriendSearchView()
}
