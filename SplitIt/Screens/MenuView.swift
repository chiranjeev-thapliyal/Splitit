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
                Color.darkGreen.ignoresSafeArea(.all)
                Spacer()
                VStack(spacing: 20) {
                    ForEach(menuList) { item in
                        NavigationLink(destination: item.view) {
                            Text(item.title)
                                .font(.title)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .kerning(3)
                                .fontWeight(.thin)
                        }
                        
                        
                        if item != menuList.last {
                            Rectangle()
                                .frame(height: 1).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 20))
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
