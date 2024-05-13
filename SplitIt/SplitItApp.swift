//
//  SplitItApp.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//
import SwiftUI
import Firebase // Import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct SplitItApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
