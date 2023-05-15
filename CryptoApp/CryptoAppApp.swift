//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 26/03/2023.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .environmentObject(HomeViewModel(dataService: CoinDataService()))
        }
    }
}
