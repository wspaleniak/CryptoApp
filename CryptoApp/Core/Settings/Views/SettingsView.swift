//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 30/10/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let googleURL = URL(string: "https://www.google.com")!
    private let youtubeURL = URL(string: "https://www.youtube.com")!
    private let appleURL = URL(string: "https://www.apple.com")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color.theme.background
                    .ignoresSafeArea()
                
                // content
                List {
                    aboutSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coingeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: dismiss)
                }
            }
        }
    }
}

extension SettingsView {
    
    private var aboutSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a youtube tutorial course. It uses MVVM Architecture, Combine and CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            Link("Check Google", destination: googleURL)
            Link("Check YouTube", destination: youtubeURL)
        } header: {
            Text("Crypto app")
        }
    }
    
    private var coingeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko. Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            Link("Visit Apple", destination: appleURL)
        } header: {
            Text("Coin gecko")
        }
    }
}

#Preview {
    SettingsView()
}
