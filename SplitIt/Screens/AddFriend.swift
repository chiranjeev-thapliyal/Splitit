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
    @State private var showError = false
    @State private var errorMessage = ""

    @EnvironmentObject var authentication: AuthenticationModel
    @StateObject var friendModel = FriendsViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                header
                friendEmailField
                searchButton
                friendDetailsSection
                Spacer()
            }
            .padding()
            .alert("User not found", isPresented: $showNotFoundAlert, presenting: tempFriendName, actions: { tempName in
                TextField("Enter name for temporary user", text: $tempFriendName)
                Button("Continue", action: createTempUser)
                Button("Cancel", role: .cancel) {}
            }, message: { tempName in
                Text("You can continue by providing a name for this new friend.")
            })
            .alert(isPresented: $showError) {
                Alert(title: Text(errorMessage), dismissButton: .default(Text("Ok")) {
                    showError = false
                    errorMessage = ""
                })
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var header: some View {
        Text("Search Friend")
            .font(.largeTitle)
            .kerning(1)
            .bold()
            .foregroundStyle(Color.darkGreen)
    }

    private var friendEmailField: some View {
        TextField("Enter friend's email", text: $friendEmail)
            .padding()
            .background(Color.tertiaryWhite)
            .cornerRadius(25)
            .foregroundColor(Color.black.opacity(0.8))
    }

    private var searchButton: some View {
        Button("Search Friend") {
            searchFriendByEmail(email: friendEmail) { success, message in
                if !success {
                    showNotFoundAlert = true
                    errorMessage = message
                } else {
                    showDetails = true
                }
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.darkGreen)
        .clipShape(Capsule())
    }

    private var friendDetailsSection: some View {
        VStack {
            if let friend = foundFriend {
                FriendCard(friend: friend, onAddFriend: addFriendAction)
            }
        }
    }
    
    func addFriendAction(friend: Friend) {
        friendModel.checkAndAddFriend(friend: friend) { success, message in
            DispatchQueue.main.async {
                errorMessage = message
                showError = true
            }
        }
    }

    func searchFriendByEmail(email: String, completion: @escaping (Bool, String) -> Void) {
        guard isValidEmail(email) else {
            completion(false, "Please enter a valid email address.")
            return
        }

        guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://wealthos.onrender.com/user/email/\(encodedEmail)") else {
            completion(false, "Please enter valid email")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, "Something went wrong: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    completion(false, "Bad response from server.")
                    return
                }

                switch httpResponse.statusCode {
                case 200:
                    do {
                        let friend = try JSONDecoder().decode(Friend.self, from: data)
                        foundFriend = friend
                        completion(true, "We found your friend")
                    } catch {
                        completion(false, "Error parsing friend data.")
                    }
                default:
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(false, errorResponse.reason)
                    } catch {
                        completion(false, "Error parsing error response.")
                    }
                }
            }
        }.resume()
    }

    func createTempUser() {
        foundFriend = Friend(id: UUID(), name: tempFriendName, email: friendEmail, imageName: "profile\(Int.random(in: 2...5))")
        showNotFoundAlert = false
    }
}

#Preview {
    FriendSearchView()
        .environmentObject(AuthenticationModel())
}
