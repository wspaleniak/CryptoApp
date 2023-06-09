//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 08/04/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // for statistics
    @Published var statistics: [Statistic] = []
    
    // for coins
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    // for searching coins
    @Published var searchText: String = ""
    
    private let coinDataService: CoinDataServiceProtocol
    private let marketDataService: MarketDataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(coinDataService: CoinDataServiceProtocol, marketDataService: MarketDataServiceProtocol) {
        self.coinDataService = coinDataService
        self.marketDataService = marketDataService
        addSubscribers()
    }
    
    // MARK: Metoda dodająca subskrybowanie wybranych zmiennych
    /// Dodajemy jednoczesne obserwowanie wpisywanego w wyszukiwarkę tekstu oraz tablicy allCoins (poprzez jej Publishera).
    /// Za każdym razem gdy zmieni się wartość wpisywanego tekstu lub tablicy, wykonujemy poniższą logikę.
    /// Używamy .debounce(for:scheduler:) aby dodać lekkie opóźnienie, gdy użytkownik, bardzo szybko wpisuje frazy do wyszukiwarki - dzięki temu kod nie wykonuje się tak często.
    /// Element .map jako argument przyjmuje poniższą funkcję filtrującą.
    /// Element .store - przechowuje subskrybcje w zmiennej cancellables.
    func addSubscribers() {
        
        // for update all coins
        $searchText
            .combineLatest(coinDataService.allCoinsPublisher)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // for update market data
        marketDataService.marketDataPublisher
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    private func mapGlobalMarketData(data: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data else {
            return stats
        }
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24hUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value", value: "$0.00", percentageChange: 0.0)
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter {
            $0.id.lowercased().contains(lowercasedText) ||
            $0.symbol.lowercased().contains(lowercasedText) ||
            $0.name.lowercased().contains(lowercasedText)
        }
    }
}
