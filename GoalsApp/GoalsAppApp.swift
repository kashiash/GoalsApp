//
//  GoalsAppApp.swift
//  GoalsApp
//
//  Created by DevTechie on 10/1/21.
//

import SwiftUI
import Firebase

@main
struct GoalsAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(repo: MockGoalRepository())
            //ContentView(repo: FirebaseGoalRepository())
        }
    }
}
