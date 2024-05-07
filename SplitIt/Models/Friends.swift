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
    var imageName: String?
}

class FriendsViewModel: ObservableObject {
    @AppStorage("user_id") var savedUserId: String?
    
    @Published var friends: [Friend] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

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
