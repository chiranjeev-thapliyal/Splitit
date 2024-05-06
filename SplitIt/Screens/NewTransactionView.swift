//
//  NewTransactionView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 03/05/24.
//

import SwiftUI

struct NewTransactionView: View {
    let friend: Friend
    
    @State var description = ""
    @State var amount = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40){
                HStack {
//                    BackButton(action: { dismiss() })
                    Spacer()
                    Text("Add Expense")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .kerning(1)
                    Spacer()
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
            
        }
        .ignoresSafeArea(edges: .all)  // Ignore the safe area for the NavigationView
        .navigationBarHidden(true)
    }
}

#Preview {
    NewTransactionView(friend: Friend(id: 1, name: "Aman", imageName: "profile"))
}
