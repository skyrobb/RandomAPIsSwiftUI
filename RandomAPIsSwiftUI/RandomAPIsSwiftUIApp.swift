//
//  RandomAPIsSwiftUIApp.swift
//  RandomAPIsSwiftUI
//
//  Created by Skyler Robbins on 1/22/25.
//

import SwiftUI

@main
struct RandomAPIsSwiftUIApp: App {
    @StateObject private var dogListManager = DogListManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dogListManager) // Inject shared instance here
        }
    }
}

