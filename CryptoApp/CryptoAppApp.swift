//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 26/03/2023.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .environmentObject(
                HomeViewModel(
                    coinDataService: CoinDataService(),
                    marketDataService: MarketDataService()
                )
            )
        }
    }
}
