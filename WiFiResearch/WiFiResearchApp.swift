//
//  WiFiResearchApp.swift
//  WiFiResearch
//
//  Created by Maxim Aliev on 13.10.2022.
//

import SwiftUI

@main
struct WiFiResearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState())
        }
    }
}
