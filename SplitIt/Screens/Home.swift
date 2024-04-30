//
//  Home.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 29/04/24.
//

import SwiftUI

struct Home: View {
    let friends = [
        Friend(name: "Chiranjeev", imageName: "profile"),
        Friend(name: "Aman", imageName: "profile"),
        Friend(name: "Rishabh", imageName: "profile"),
        Friend(name: "Jaskaran", imageName: "profile"),
        Friend(name: "Abhishek", imageName: "profile"),
        Friend(name: "Vaishnavi", imageName: "profile")
    ]
    
    
    
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
            ScrollView {
                    HStack {
                        Spacer()
                        HeaderTitle(first: "wealth", second: "OS") // Assuming this is a custom component that you have defined elsewhere
                        Spacer()
                    }
                    .padding(.top, 8)

                    VStack(spacing: 0) {
                        
                        // User's Summary Card
                        VStack(spacing: 12) {
                            Text("Chiranjeev Thapliyal")
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
                        
                        // Friends Card
                        VStack(spacing: 0) {
                            Text("Friends")
                                .textCase(.uppercase)
                                .font(.subheadline)
                                .kerning(1)
                                .foregroundStyle(Color.tertiaryWhite)
                                .padding(.top, 16)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(friends, id: \.self){friend in
                                        FriendHome(name: friend.name, image: friend.imageName)
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
                                HStack(spacing: 12){
                                    ForEach(friends, id: \.self){ group in
                                        FriendHome(name: group.name, image: group.imageName)
                                    }
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
                    }
                    
                }
                .background(Color.tertiaryWhite)

        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct Friend: Hashable {
    var name: String
    var imageName: String
}

#Preview {
    Home()
}
