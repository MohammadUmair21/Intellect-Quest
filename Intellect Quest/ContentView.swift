//
//  ContentView.swift
//  Intellect Quest
//
//  Created by Umair on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            
            ProfileView()
                .tabItem {
                   Label("Profile", systemImage: "person")
                }
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
