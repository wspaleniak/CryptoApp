//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 08/04/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // market data
    @Published var statistics: [Statistic] = []
    
    // all coins
    @Published var allCoins: [Coin] = []
    
    // portfolio coins
    @Published var portfolioCoins: [Coin] = []
    
    // searching coins
    @Published var searchText: String = ""
    
    // services
    private let coinDataService: CoinDataServiceProtocol
    private let marketDataService: MarketDataServiceProtocol
    private let portfolioDataService: PortfolioDataServiceProtocol
    
    // store subscribers
    private var cancellables = Set<AnyCancellable>()
    
    init(
        coinDataService: CoinDataServiceProtocol,
        marketDataService: MarketDataServiceProtocol,
        portfolioDataService: PortfolioDataServiceProtocol
    ) {
        self.coinDataService = coinDataService
        self.marketDataService = marketDataService
        self.portfolioDataService = portfolioDataService
        addSubscribers()
    }
    
    // MARK: Metoda dodająca subskrybowanie wybranych zmiennych
    /// Dodajemy jednoczesne obserwowanie wpisywanego w wyszukiwarkę tekstu oraz tablicy allCoins (poprzez jej Publishera).
    /// Za każdym razem gdy zmieni się wartość wpisywanego tekstu lub tablicy, wykonujemy poniższą logikę.
    /// Używamy .debounce(for:scheduler:) aby dodać lekkie opóźnienie, gdy użytkownik, bardzo szybko wpisuje frazy do wyszukiwarki - dzięki temu kod nie wykonuje się tak często.
    /// Element .map jako argument przyjmuje poniższą funkcję filtrującą.
    /// Element .store - przechowuje subskrybcje w zmiennej cancellables.
    ///
    /// Używam tutaj odwołania do Publisher'ów w serwisach, a nie zmiennych oznaczonych jako @Published ponieważ mock'uje oryginalne serwisy przy pomocy zgodności z danym protokołem. Wtedy w protokole trzeba dodać jeszcze Publisher'a, który będzie publikował zmiany dla zmiennej oznaczonej jako @Published. W protokole nie jesteśmy w stanie oznaczyć zmiennej jako @Published, natomiast możemy dać wymóg, że dany serwis zgodny z protokołem musi posiadać Publisher'a.
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
        
        // for update portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.savedEntitiesPublisher)
            .map(mapAllCoinsForPorfolio)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    /// Metoda aktualizuje dane dla portfolio użytkownika.
    /// Używamy w tym celu metody zdefiniowanej w portfolio data service.
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    /// Metoda modyfikuje dane które otrzymujemy podczas subskrybowania zmiennych dla portfolio coins.
    private func mapAllCoinsForPorfolio(coins: [Coin], entities: [PortfolioEntity]) -> [Coin] {
        return coins
            .compactMap { (coin) -> Coin? in
                guard let entity = entities.first(where: { $0.coinID == coin.id }) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    /// Metoda modyfikuje dane które otrzymujemy podczas subskrybowania zmiennych dla market data.
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
    
    /// Metoda modyfikuje dane które otrzymujemy podczas subskrybowania zmiennych dla all coins.
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
