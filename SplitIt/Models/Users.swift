//
//  Users.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import Foundation
import SwiftUI

struct PublicUser: Codable, Hashable {
    let id: UUID
    let name: String
}

struct TemporaryUser: Codable, Hashable {
    let id: UUID
    let name: String
    let email: String
}

struct BalanceResponse: Codable, Hashable {
    let totalBalance: Double
}

class UserModel: ObservableObject {
    @AppStorage("user_id") var userId: String?
    
    @Published var totalBalance: Double = 0
    let session = URLSession.shared
    
    func getUserBalance() {
        guard let userId = userId, let url = URL(string: "https://wealthos.onrender.com/transactions/user/\(userId)/balance") else {
            print("Invalid url for balance")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request){ data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response from server")
                return
            }
            
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    do {
                        let result = try JSONDecoder().decode(BalanceResponse.self, from: data)
                        self.totalBalance = result.totalBalance
                    } catch {
                        print("Failed to decode the response: \(error.localizedDescription)")
                    }
                    
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    
}
