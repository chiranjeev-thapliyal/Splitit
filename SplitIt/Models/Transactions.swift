//
//  Transactions.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import Foundation
import SwiftUI

struct Share: Codable, Hashable {
    let userId: UUID
    let userName: String
    let percentage: Double
}

struct Transaction: Codable, Hashable {
    let id: UUID
    let creator: UUID
    let creatorName: String
    let amount: Double
    let description: String
    let shares: [Share]
}

class TransactionModel: ObservableObject {
    @AppStorage("user_id") var savedUserId: String?
    
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getUserTransactions(){
        isLoading = true
        errorMessage = nil
        
        if let userId = savedUserId {
            let url = URL(string: "https://wealthos.onrender.com/user/\(userId)/transactions")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    guard let data = data, error == nil else {
                        self?.errorMessage = "Failed to load transactions: \(error?.localizedDescription ?? "Unknown error")"
                        return
                    }
                    
                    do {
                        self?.transactions = try JSONDecoder().decode([Transaction].self, from: data)
                    } catch {
                        print("failed to decode \(error.localizedDescription)")
                        self?.errorMessage = "Failed to decode groups data"
                    }
                }
            }.resume()
        }
    }
}
