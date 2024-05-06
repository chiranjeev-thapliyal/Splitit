//
//  TransactionView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 03/05/24.
//

import SwiftUI

struct TransactionView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        BackButton(action: { dismiss() })
                        Spacer()
                        
                        Image(systemName: "ellipsis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.tertiaryWhite)
                            .rotationEffect(.degrees(90))
                            .frame(width: 20, height: 20)
                        
                    }.padding(.top, 32)
                    
                    VStack(spacing: 16) {
                        VStack(spacing: 8) {
                            CircularImage(width: 80, height: 80, strokeColor: Color.tertiaryWhite, icon: "airplane", isSystemIcon: true)
                            Text("Goa Flight")
                                .font(.headline)
                                .foregroundStyle(Color.tertiaryWhite)
                                .kerning(1)
                        }
                        
                        HStack(alignment: .lastTextBaseline) {
                            Text("₹")
                                .font(.title)
                                .foregroundStyle(Color.tertiaryWhite)
                            
                            Text("20,000.00")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(Color.tertiaryWhite)
                        }
                            
                    }
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 24)
                .background(Color.darkGreen)
                .clipShape(BottomRoundedRectangle(radius: 25))
                .ignoresSafeArea(edges: .top)
                
            
                VStack {
                    Text("Split Details")
                        .textCase(.uppercase)
                        .kerning(1)
                        .bold()
                        .font(.caption)
                        .foregroundStyle(Color.regularGreen)
                    
                    Divider()
                    
                    VStack(spacing: 16){
                        HStack(alignment: .center, spacing: 0) {
                            CircularImage(width: 52, height: 52, strokeColor: Color.regularGreen, icon: "profile")
                            Text("Chiranjeev T. paid ₹ \(20000)")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                                .frame(maxWidth: 200)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                
                            Spacer()
                        }
                        
                        HStack(alignment: .center, spacing: 8) {
                            CircularImage(width: 52, height: 52, strokeColor: Color.regularGreen, icon: "profile5")
                            Text("Vaibhav P. paid ₹ 2000.00 and owes ₹ \(20000/3)")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                                .frame(maxWidth: 200)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            CircularImage(width: 52, height: 52, strokeColor: Color.regularGreen, icon: "profile3")
                            Text("Chirag G. owes ₹ \(20000/3) to Chiranjeev T.")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                                .frame(maxWidth: 200)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer()
                        }

                    }.padding(.vertical, 8)
                    
                    Divider()
                    
                }.padding(.horizontal, 32)
                
                Spacer()
            }
        }
        .ignoresSafeArea(edges: .all)
        .navigationBarHidden(true)
    }
}

#Preview {
    TransactionView()
}
