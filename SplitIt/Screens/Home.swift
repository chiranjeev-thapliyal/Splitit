//
//  Home.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 29/04/24.
//

import SwiftUI

struct Home: View {
    @AppStorage("token") var savedToken: String = ""
    @AppStorage("name") var savedName: String = ""
    @AppStorage("email") var savedEmail: String = ""
    
    let friends = [
        Friend(id: 1, name: "Chiranjeev", imageName: "profile"),
        Friend(id: 6, name: "Vaishnavi", imageName: "profile4"),
        Friend(id: 2, name: "Aman", imageName: "profile2"),
        Friend(id: 4, name: "Jaskaran", imageName: "profile5"),
        Friend(id: 3, name: "Rishabh", imageName: "profile3"),
        Friend(id: 5, name: "Abhishek", imageName: "profile")
    ]
    
    func getFriends(){
        
    }
    
    func getGroups(){
        
    }
    
    fileprivate func ProfileHome() -> ZStack<TupleView<(some View, some View)>> {
        return ZStack(alignment: .bottomTrailing) {
            // Profile Image
            Circle()
                .strokeBorder(Color.tertiaryWhite, lineWidth: 4)
                .overlay(
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .padding(4)
                )
                .frame(width: 100, height: 100)
            
            // Profile Add(+) Button
            Circle()
                .fill(Color.darkGreen)
                .overlay(
                    Image(systemName: "plus") // System image
                        .foregroundColor(Color.tertiaryWhite)
                )
                .frame(width: 30, height: 30)
                .offset(x: 0, y: 0)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        HeaderTitle(first: "wealth", second: "OS")
                            .kerning(2)
                            .font(.largeTitle)
                            .fontWeight(.thin)
                        
                        Spacer()
                    }
                    .padding(.top, 8)
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            // User's Summary Card
                            VStack(spacing: 12) {
                                Text(savedName)
                                    .font(.headline)
                                    .foregroundStyle(Color.tertiaryWhite)
                                    .textCase(.uppercase)
                                    .fontWeight(.light)
                                    .kerning(1)
                                
                                ProfileHome()
                                
                                VStack(spacing: 4) {
                                    Text("TOTAL BALANCE")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text("₹ 2254.75")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(Color.tertiaryWhite)
                                }

                            }
                            .frame(maxWidth: .infinity) // Use infinity to ensure it expands
                            .padding(.horizontal, 8) // Add horizontal padding to the card
                            .padding(.vertical, 16)
                            .background(LinearGradient(colors: [.darkGreen, .regularGreen, .lightGreen], startPoint: .top, endPoint: .bottom))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .zIndex(1)
                            
                            // Friends
                            VStack(spacing: 0) {
                                Text("Friends")
                                    .textCase(.uppercase)
                                    .font(.subheadline)
                                    .kerning(1)
                                    .foregroundStyle(Color.tertiaryWhite)
                                    .padding(.top, 16)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(friends.shuffled(), id: \.self){friend in
                                            NavigationLink(destination: NewTransactionView(friend: friend)){
                                                FriendHome(name: friend.name, image: friend.imageName)
                                            }
                                            
                                        }
                                    }
                                    .padding(.horizontal, 8) // Add horizontal padding to the card
                                    .padding(.vertical, 12)
                                }

                            }
                            .background(Color.regularGreen)
                            .clipShape(BottomRoundedRectangle(radius: 16))
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                            
                            // Groups Card
                            VStack(spacing: 0){
                                Text("Groups")
                                    .font(.subheadline)
                                    .textCase(.uppercase)
                                    .kerning(1)
                                    .foregroundStyle(Color.tertiaryWhite)
                                    .padding(.top, 16)
                                
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing: 20){
                                        Spacer()
                                        ForEach(friends.shuffled().prefix(4), id: \.self){ group in
                                            FriendHome(name: group.name, image: group.imageName)
                                                .multilineTextAlignment(.center)
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal, 8) // Add horizontal padding to the card
                                    .padding(.vertical, 12)
                                    
                                }
                            }
                            
                                
                        }
                        .background(RoundedRectangle(cornerRadius: 16).fill(LinearGradient(colors: [.lightGreen, .regularGreen, .darkGreen], startPoint: .top, endPoint: .bottom)))
                        .padding(12)
                        
                        
                        
                        // Rest of the content
                        VStack {
                            Text("Activity")
                                .font(.subheadline)
                                .textCase(.uppercase)
                                .kerning(1)
                                .foregroundStyle(Color.darkGreen)
                            
                            Rectangle()
                                .frame(height: 1).foregroundStyle(Color.darkGreen).clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            VStack {
                                TransactionRow(payee: "Chiranjeev", amount: 1000, members: ["Jaskaran", "Abhishek"], label: "Movie", icon: "movieclapper.fill", isSystemIcon: true)
                                Divider()
                                TransactionRow(payee: "Chiranjeev", amount: 2000, members: ["Jaskaran", "Abhishek"], label: "Dinner",  icon: "fork.knife", isSystemIcon: true)
                                Divider()
                                TransactionRow(payee: "Chiranjeev", amount: 500, members: ["Jaskaran", "Abhishek"], label: "Recharge",  icon: "platter.2.filled.iphone", isSystemIcon: true)
                                Divider()
                                TransactionRow(payee: "Chiranjeev", amount: 750, members: ["Jaskaran", "Abhishek"], label: "Cab",  icon: "car", isSystemIcon: true)
                                Divider()
                                TransactionRow(payee: "Chiranjeev", amount: 1000, members: ["Jaskaran", "Abhishek"], label: "Flight",  icon: "airplane.departure", isSystemIcon: true)
                                Divider()
                                TransactionRow(payee: "Chiranjeev", amount: 1205, members: ["Jaskaran", "Abhishek"], label: "Food",  icon: "fork.knife", isSystemIcon: true)
                                
                            }
                            
                            
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        
                    }
                    .background(Color.tertiaryWhite)
                }
                
                NavigationLink(destination: {}){
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundStyle(Color.tertiaryWhite)
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        .background(Color.darkGreen)
                        .cornerRadius(28)
                    
                }
                .padding()
                .accessibilityLabel("Add New Item")
            }
            .background(Color.tertiaryWhite)
        
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

#Preview {
    Home()
}
