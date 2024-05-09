//
//  NewTransactionView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 03/05/24.
//

import SwiftUI

struct NewTransactionView: View {
    let friend: Friend
    
    @AppStorage("user_id") var savedUserId: String?
    @AppStorage("token") var savedToken: String?
    @AppStorage("name") var savedName: String?
    @AppStorage("email") var savedEmail: String?
    
    @State var description = ""
    @State var amount = ""
    
    @State var showAlert = false
    @State var alertMessage = ""
    @State var navigateToHome = false
    
    @Environment(\.dismiss) var dismiss
    
    func addTransaction(){
        if amount.isEmpty || description.isEmpty {
            showAlert = true
            alertMessage = "Enter all details"
            return
        }
        
        guard let url = URL(string: "http://192.168.1.3:8080/transactions"),
              let userId = UUID(uuidString: savedUserId ?? ""),
              let userName = savedName,
              let amount = Double(self.amount) else {
            showAlert = true
            alertMessage = "Invalid data or configuration"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let transaction = Transaction(
            id: UUID(),
            creator: userId,
            creatorName: userName,
            amount: amount,
            description: self.description,
            shares: [
                Share(userId: userId, userName: userName, percentage: 50),
                Share(userId: UUID(uuidString: friend.id)!, userName: friend.name, percentage: 50)
            ])
        
        do {
            request.httpBody = try JSONEncoder().encode(transaction)
        } catch {
            showAlert = true
            alertMessage = "Unable to encode transaction"
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
           
            DispatchQueue.main.async {
                if let data = data {
                    prettyPrint(data: data)
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response from server")
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    print("Transaction successfully added")
                    showAlert = true
                    alertMessage = "Success!"
                    self.navigateToHome = true
                    
                    print("Transaction successfully added \(navigateToHome)")
                    return
                } else {
                    print("Failed to add transaction, HTTP Status: \(httpResponse.statusCode)")
                    showAlert = true
                    alertMessage = "Please try again"
                }
                
                if let error = error {
                    print("HTTP request failed \(error)")
                    showAlert = true
                    alertMessage = "Please try again"
                }
                
            }
            
        }.resume()
        
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40){
                HStack {
                    BackButton(action: { dismiss() })
                    Spacer()
                    Text("Add Expense")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .kerning(1)
                    Spacer()
                    
                    Button(action: {addTransaction()}){
                        Text("Save")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.crimson)
                            .kerning(1)
                    }
                    
                }
                .padding(.top, 32)
                .padding(.horizontal, 12)
                .padding(.vertical, 16)
                .background(Color.darkGreen)
                .clipShape(BottomRoundedRectangle(radius: 25))
                .ignoresSafeArea(edges: .top)  // Make sure the background ignores the safe area

                VStack {
                    Text("With you and:")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.bold)
                        .kerning(1)
                    
                    VStack(spacing: 0) {
                        HStack {
                            CircularImage(width: 28, height: 28, icon: "profile")
                            
                            Text(friend.name)
                                .font(.subheadline)
                                .foregroundStyle(Color.tertiaryWhite)
                                .kerning(1)
                                .fontWeight(.medium)
                                
                                
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.regularGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 1)
                            .foregroundStyle(Color.regularGreen)
                            .padding()
                    }
                   
                        
                    
                }.padding(.horizontal, 16)
                
                VStack {
                    HStack(spacing: 16) {
                        CircularImage(width: 44, height: 44, strokeColor: Color.regularGreen, icon: "list.bullet", isSystemIcon: true)
                        VStack {
                            TextField("Enter Description", text: $description)
                            Divider()
                        }
                    }
                    
                    HStack(spacing: 16) {
                        CircularImage(width: 44, height: 44, strokeColor: Color.regularGreen, icon: "indianrupeesign", isSystemIcon: true)
                        VStack {
                            TextField("0.00", text: $amount)
                                .keyboardType(.numberPad)
                            Divider()
                        }
                    }
                }.padding(.horizontal, 16)

                
                HStack {
                    Text("Paid by")
                        .foregroundStyle(Color.gray)
                        .bold()
                        .kerning(1)
                    
                    Text("You")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 16)
                        .foregroundStyle(Color.tertiaryWhite)
                        .background(Color.regularGreen)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25.0)
                        )
                        .bold()
                        .kerning(1)
                    
                    Text("and split")
                        .foregroundStyle(Color.gray)
                        .bold()
                        .kerning(1)
                    
                    Text("Equally")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 16)
                        .foregroundStyle(Color.tertiaryWhite)
                        .background(Color.regularGreen)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25.0)
                        )
                        .bold()
                        .kerning(1)
                    
                }
                
                Spacer()
                
                HeaderTitle(first: "wealth", second: "OS")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                
                
            }
            .alert(isPresented: $showAlert){
                Alert(title: Text(alertMessage), dismissButton: .default(Text("Ok")){
                    self.navigateToHome = true
                })
            }
            
            NavigationLink(destination: Home(), isActive: $navigateToHome) {
                EmptyView()
            }
            
        }
        .ignoresSafeArea(edges: .all)  // Ignore the safe area for the NavigationView
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    NewTransactionView(friend: Friend(id: "1", name: "Aman", imageName: "profile"))
}
