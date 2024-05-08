//
//  FloatingMenu.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 08/05/24.
//

import SwiftUI

struct FloatingMenu: View {
    @State private var isOpen = false
    @State private var showFriendsList = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if isOpen {
                Color.black.opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isOpen = false
                        }
                    }
            }
            
            VStack(alignment: .trailing, spacing: 16) {
                if isOpen {
                    MenuOption(icon: "person.badge.plus", text: "Add Friends", action: {
                        showFriendsList = true
                        isOpen = false // Close the menu
                    })
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                    .sheet(isPresented: $showFriendsList) {
                        ContactList()
                    }
                    
                    MenuOption(icon: "person.2.fill", text: "Create Group", action: { print("Create Group selected") })
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    
                    MenuOption(icon: "gear", text: "Settings", action: { print("Settings selected") })
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
                
                Button(action: {
                    withAnimation {
                        isOpen.toggle()
                    }
                }) {
                    Image(systemName: isOpen ? "xmark" : "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(isOpen ? Color.green : Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .zIndex(2)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
}

#Preview {
    FloatingMenu()
}
