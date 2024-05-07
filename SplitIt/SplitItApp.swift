//
//  SplitItApp.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 09/04/24.
//

import SwiftUI

@main
struct SplitItApp: App {
    init() {
        UserDefaults.standard.set("7CC633B1-6DCD-4D61-B833-DC244993E529", forKey: "user_id")
        UserDefaults.standard.set("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhY2Nlc3NUb2tlbiIsImV4cCI6NjQwOTIyMTEyMDAuMCwiZGF0YSI6eyJuYW1lIjoiQ2hpcmFuamVldiBUaGFwbGl5YWwiLCJlbWFpbCI6ImNoaXJhbmplZXZAZ21haWwuY29tIn19.H9IO3skrA4OMlpnH7WHk_A3qQ8UW6kkHIoE5X-cbZqA", forKey: "token")
        UserDefaults.standard.set("Vaishnavi Kawthankar", forKey: "name")
        UserDefaults.standard.set("vaishnavi@gmail.com", forKey: "email")
        
        // Ensure UserDefaults are synchronized
        UserDefaults.standard.synchronize()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
