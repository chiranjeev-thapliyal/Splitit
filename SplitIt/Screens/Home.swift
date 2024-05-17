//
//  Home.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 29/04/24.
//

import SwiftUI

struct Home: View {
    @StateObject var friendsModel = FriendsViewModel()
    @StateObject var transactionModel = TransactionModel()
    @StateObject var userModel = UserModel()
    
    @State var navigateToMenu = false
    @State private var isNotAuthenticated = false
    
    @State var openLogoutDialog = false
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var authentication: AuthenticationModel
    
    func getHomePageData(){
        userModel.getUserBalance()
        friendsModel.getFriends()
        transactionModel.getUserTransactions()
    }
    
    private func updateAuthenticationStatus() {
        isNotAuthenticated = !authentication.isAuthenticated
    }
    
        var body: some View {
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    VStack(spacing: 0) {
                        CustomNavbar(leftIcon: "line.horizontal.3", leftIconAction: { self.navigateToMenu = true }, rightIcon: "power", rightIconAction: { 
                            openLogoutDialog = true
                        })
                            .background(
                                NavigationLink(destination: MenuView(), isActive: $navigateToMenu) { EmptyView()
                                }
                            )
                            .padding(.horizontal, 16)
    
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 0) {
                                // User's Summary Card
                                VStack(spacing: 12) {
                                    Text(authentication.savedName ?? "User")
                                        .font(.headline)
                                        .foregroundStyle(Color.tertiaryWhite)
                                        .textCase(.uppercase)
                                        .fontWeight(.light)
                                        .kerning(1)
    
                                    CircularImageWithAction()
    
                                    VStack(spacing: 4) {
                                        Text("TOTAL BALANCE")
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.7))
                                        Text("₹ \(addPrecision(userModel.totalBalance, precision: 2))")
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
                                            ForEach(transactionModel.transactions.reversed(), id: \.self){ transaction in
                                                NavigationLink(destination: TransactionView(transaction: transaction)){
                                                    TransactionRow(payee: transaction.creatorName, amount: transaction.amount, members: transaction.shares, label: transaction.description, icon:  symbolForTransaction(transaction.description), isSystemIcon: true)
                                                }
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
                                                .foregroundStyle(colorScheme == .dark ? Color.tertiaryWhite : Color.black.opacity(0.9))
                                                .kerning(1)
                                        }
    
                                    }
    
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                        }
                    }
    
                    FloatingMenu()
                        .accessibilityLabel("Add New Item")
    
                    NavigationLink(destination: ContentView(), isActive: $isNotAuthenticated) {
                        EmptyView()
                    }
    
                }
                .refreshable {
                    getHomePageData()
                }
                .alert(isPresented: $openLogoutDialog){
                    Alert(title: Text("Are you sure?"), message: Text("Do you want to continue to logout?"), primaryButton: .default(Text("Yes")){
                        authentication.logoutUser()
                    }, secondaryButton: .destructive(Text("No")){
                        openLogoutDialog = false
                    })
                }
    
            }
            .onAppear {
                getHomePageData()
                updateAuthenticationStatus()
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    getHomePageData()
                }
            }
            .onChange(of: authentication.isAuthenticated) { isAuthenticated in
                isNotAuthenticated = !isAuthenticated
            }
        }
}

#Preview {
    Home().environmentObject(AuthenticationModel())
}

