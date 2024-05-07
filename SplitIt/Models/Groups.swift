//
//  Groups.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import Foundation
import SwiftUI

struct UserGroup: Codable, Hashable {
    let id: UUID
    let name: String
    let members: [PublicUser]
}

class GroupModel: ObservableObject {
    @AppStorage("user_id") var savedUserId: String?
    
    @Published var groups: [UserGroup] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getGroups() {
        isLoading = true
        errorMessage = nil
        
        if let userId = savedUserId {
            let url = URL(string: "http://localhost:8080/user/\(userId)/groups")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    guard let data = data, error == nil else {
                        self?.errorMessage = "Failed to load groups: \(error?.localizedDescription ?? "Unknown error")"
                        return
                    }
                    
                    do {
                        self?.groups = try JSONDecoder().decode([UserGroup].self, from: data)
                    } catch {
                        self?.errorMessage = "Failed to decode groups data"
                    }
                }
            }.resume()
        }
        
        
    }
}
