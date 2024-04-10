//
//  MenuView.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 11/04/24.
//

import SwiftUI

struct MenuItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let view: AnyView
    
    static func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
        lhs.id == rhs.id
    }
}

struct MenuView: View {
    let menuList = [
        MenuItem(title: "Home", view: AnyView(SignupView())),
        MenuItem(title: "Settings", view: AnyView(SignupView())),
        MenuItem(title: "Rate Splitwise", view: AnyView(SignupView())),
        MenuItem(title: "Contact Us", view: AnyView(SignupView())),
        MenuItem(title: "Log out", view: AnyView(SignupView()))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.primaryGreen.ignoresSafeArea(.all)
                Spacer()
                VStack(spacing: 20) {
                    ForEach(menuList) { item in
                        NavigationLink(destination: item.view) {
                            Text(item.title)
                                .font(.custom("Rubik-Light", size: 28))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                        }
                        
                        
                        if item != menuList.last {
                            Rectangle()
                                .frame(height: 2).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        
                    }
                }
                .textCase(.uppercase)
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }.navigationTitle("Menu")
    }
}

#Preview {
    MenuView()
}
