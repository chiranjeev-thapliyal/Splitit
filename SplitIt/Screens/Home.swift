//
//  Home.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 29/04/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    HStack {
                        Spacer()
                        HeaderTitle(first: "wealth", second: "OS") // Assuming this is a custom component that you have defined elsewhere
                        Spacer()
                    }
                    .padding(.top, 40) // Moved padding to the HStack

                    // User's Summary Card
                    VStack(spacing: 16) {
                        Text("Chiranjeev Thapliyal")
                            .font(.headline)
                            .foregroundStyle(Color.tertiaryWhite)
                            .textCase(.uppercase)
                        
                        ZStack(alignment: .bottomTrailing) {
                            // Profile Image
                            Circle()
                                .strokeBorder(Color.tertiaryWhite, lineWidth: 4)
                                .background(Circle().fill(Color.tertiaryWhite))
                                .overlay(
                                    Image("profile")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                )
                                .frame(width: 150, height: 150)
                            
                            // Profile Add(+) Button
                            Circle()
                                .fill(Color.darkGreen)
                                .overlay(
                                    Image(systemName: "plus") // System image
                                        .foregroundColor(Color.tertiaryWhite)
                                )
                                .frame(width: 30, height: 30)
                                .offset(x: -15, y: 0)
                        }
                        
                        VStack(spacing: 4) {
                            Text("TOTAL BALANCE")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                            Text("₹ 2254.75")
                                .font(.title)
                                .foregroundColor(.white)
                        }

                    }
                    .frame(maxWidth: .infinity) // Use infinity to ensure it expands
                    .padding(.horizontal) // Add horizontal padding to the card
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    .background(LinearGradient(colors: [.darkGreen, .darkGreen, .regularGreen], startPoint: .top, endPoint: .bottom))
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .padding(12)
                    
                    // Rest of the content
                    VStack {
                        Text("Activity")
                    }
                    
                    Spacer() // This spacer will push everything to the top
                }
                .background(Color.tertiaryWhite)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

#Preview {
    Home()
}
