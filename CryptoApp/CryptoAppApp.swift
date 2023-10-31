//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 26/03/2023.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @State private var showLaunchView: Bool = true
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }
                .environmentObject(
                    HomeViewModel(
                        coinDataService: coinDataService,
                        marketDataService: marketDataService,
                        portfolioDataService: portfolioDataService
                    )
                )
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
