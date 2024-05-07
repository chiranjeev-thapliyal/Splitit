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
    
    @StateObject var friendsModel = FriendsViewModel()
    @StateObject var groupsModel = GroupModel()
    @StateObject var transactionModel = TransactionModel()
    
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
            
            EmptyView()
            
            // Profile Add(+) Button
//            Circle()
//                .fill(Color.darkGreen)
//                .overlay(
//                    Image(systemName: "plus") // System image
//                        .foregroundColor(Color.tertiaryWhite)
//                )
//                .frame(width: 30, height: 30)
//                .offset(x: 0, y: 0)
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
                                    Text("₹ 0")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(Color.tertiaryWhite)
                                }

                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 16)
                            .background(LinearGradient(colors: [.darkGreen, .regularGreen, .lightGreen], startPoint: .top, endPoint: .bottom))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .zIndex(1)
                            
                            // Friends
                            if !friendsModel.friends.isEmpty {
                                FriendsList(title: "Friends", friendsList: friendsModel.friends)
                                    .background(Color.regularGreen)
                                    .clipShape(BottomRoundedRectangle(radius: 16))
                                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                            }
                            
                            // Groups Card
                            if !groupsModel.groups.isEmpty {
                                GroupsList(title: "Groups", groupsList: groupsModel.groups)
                                    .background(Color.darkGreen.opacity(0.1))
                                    .clipShape(BottomRoundedRectangle(radius: 16))
                                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                            }
                            
                                
                        }
                        .background(RoundedRectangle(cornerRadius: 16).fill(LinearGradient(colors: [.lightGreen, .regularGreen, .darkGreen], startPoint: .top, endPoint: .bottom)))
                        .padding(12)
                        
                        
                        
                            VStack {
                                Text("Activity")
                                    .font(.subheadline)
                                    .textCase(.uppercase)
                                    .kerning(1)
                                    .foregroundStyle(Color.darkGreen)
                                
                                Rectangle()
                                    .frame(height: 1).foregroundStyle(Color.darkGreen).clipShape(RoundedRectangle(cornerRadius: 20))
                                
                               
                                VStack {
                                    if !transactionModel.transactions.isEmpty {
                                        ForEach(transactionModel.transactions, id: \.self){ transaction in
                                            TransactionRow(payee: transaction.creatorName, amount: transaction.amount, members: [], label: transaction.description, icon: "movieclapper.fill", isSystemIcon: true)
                                            Divider()
                                        }
                                    } else {
                                        Image("no-results-found")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 150, height: 150)
                                        
                                        Text("No Transactions Found")
                                            .font(.headline)
                                            .fontWeight(.light)
                                            .foregroundStyle(Color.black.opacity(0.9))
                                            .kerning(1)
                                    }
                                
                                }
                                
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                    }
                    .background(Color.tertiaryWhite)
                }
                
//                NavigationLink(destination: {}){
//                    Image(systemName: "plus")
//                        .font(.title)
//                        .foregroundStyle(Color.tertiaryWhite)
//                        .frame(width: 56, height: 56)
//                        .clipShape(Circle())
//                        .background(Color.darkGreen)
//                        .cornerRadius(28)
//                    
//                }
//                .padding()
//                .accessibilityLabel("Add New Item")
            }
            .background(Color.tertiaryWhite)
        
        }
        .onAppear{
            friendsModel.getFriends()
            groupsModel.getGroups()
            transactionModel.getUserTransactions()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    Home()
}

