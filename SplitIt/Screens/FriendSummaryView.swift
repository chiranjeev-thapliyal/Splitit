//
//  FriendSummaryView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 01/05/24.
//

import SwiftUI

struct FriendSummaryView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // Top Card
            VStack(spacing: 16) {
                Spacer().frame(height: 100)
                
                HStack {
                    BackButton(action: { dismiss() })
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.tertiaryWhite)
                        .rotationEffect(.degrees(90))
                        .frame(height: 5)
                }
                
                VStack(spacing: 16) {
                    CircularImage(width: 150, height: 150, icon: "profile")
                    
                    VStack {
                        Text("Chiranjeev Thapliyal")
                            .font(.headline)
                            .foregroundStyle(Color.tertiaryWhite)
                            .fontWeight(.bold)
                            .kerning(1)
                            
                        Text("+91 9xxxxxxx47")
                            .font(.headline)
                            .foregroundStyle(Color.tertiaryWhite)
                            .fontWeight(.regular)
                            .kerning(1)
                    }
                    
                    VStack {
                        Text("owes you")
                            .font(.caption)
                            .foregroundStyle(Color.tertiaryWhite)
                            .fontWeight(.regular)
                            .textCase(.uppercase)
                            .kerning(1)
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("₹")
                                .font(.title2)
                                .foregroundStyle(Color.tertiaryWhite)
                                .fontWeight(.regular)
                                .textCase(.uppercase)
                                .kerning(1)
                            
                            Text("560.50")
                                .font(.largeTitle)
                                .foregroundStyle(Color.tertiaryWhite)
                                .fontWeight(.heavy)
                                .textCase(.uppercase)
                                .kerning(1)
                        }
                    }
                    
                    Spacer()
                    
                    // Settle Up Button
                    NavigationLink(destination: MenuView()){
                        Text("Settle Up")
                            .padding(.vertical, 16)
                            .padding(.horizontal, 48)
                            .foregroundStyle(Color.tertiaryWhite)
                            .background(Color.darkGreen)
                            .textCase(.uppercase)
                            .kerning(1)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            
                    }
                    .offset(y: -32)
                    .zIndex(1)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, maxHeight: 440)
            .background(LinearGradient(colors: [Color.darkGreen, Color.regularGreen, Color.lightGreen], startPoint: .top, endPoint: .bottom))
           
            ScrollView(showsIndicators: false) {
                // Transactions
                VStack {
                    // Heading
                    VStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 1)
                            .foregroundStyle(Color.regularGreen)
                        
                        Text("Activity")
                            .foregroundStyle(Color.regularGreen)
                            .textCase(.uppercase)
                            .fontWeight(.medium)
                            .kerning(3)
                            .font(.subheadline)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 1)
                            .foregroundStyle(Color.regularGreen)
                    }
                    
                    // Transactions
                    VStack(spacing: 8) {
                       TransactionRow(payee: "Chiranjeev", amount: 500, members: ["Jaskaran"], label: "Movie", icon: "movieclapper", isSystemIcon: true)
                        
                        Divider()
                        
                       TransactionRow(payee: "Chiranjeev", amount: 500, members: ["Jaskaran"], label: "Movie", icon: "movieclapper", isSystemIcon: true)
                          
                    }
                    .padding(.vertical, 8)
                    
                    
                }
                .padding(.top, 52)
                .padding(.horizontal, 16)
                
                VStack {
                    // Heading
                    VStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 1)
                            .foregroundStyle(Color.regularGreen)
                        
                        Text("October")
                            .foregroundStyle(Color.regularGreen)
                            .textCase(.uppercase)
                            .fontWeight(.medium)
                            .kerning(3)
                            .font(.subheadline)
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 1)
                            .foregroundStyle(Color.regularGreen)
                    }
                    
                    // Transactions
                    VStack(spacing: 12) {
                        ForEach(1...5, id: \.self){ index in
                            TransactionRow(payee: "Chiranjeev", amount: 500, members: ["Jaskaran"], label: "Movie", icon: "movieclapper", isSystemIcon: true)
                             
                            if index != 5 {
                                Divider()
                            }
                             
                        }
                          
                    }
                    .padding(.vertical, 8)
                    
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
            }.zIndex(-1)
            
            
            
            // Floating Add Item Button
            
            Spacer()
        }
        .background(Color.tertiaryWhite)
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        
    
    }
}

#Preview {
    FriendSummaryView()
}
