//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 08/04/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    enum SortOption {
        case rank
        case rankReversed
        case holdings
        case holdingsReversed
        case price
        case priceReversed
    }
    
    // Market data
    @Published var statistics: [Statistic] = []
    
    // All coins
    @Published var allCoins: [Coin] = []
    
    // Portfolio coins
    @Published var portfolioCoins: [Coin] = []
    
    // Reload data
    @Published var isLoading: Bool = false
    
    // Searching coins
    @Published var searchText: String = ""
    
    // Sort option
    @Published var sortOption: SortOption = .rank
    
    // Services
    private let coinDataService: CoinDataServiceProtocol
    private let marketDataService: MarketDataServiceProtocol
    private let portfolioDataService: PortfolioDataServiceProtocol
    
    // Store subscribers
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
    /// Używamy .debounce(for:scheduler:) aby dodać lekkie opóźnienie, gdy użytkownik, bardzo szybko wpisuje frazy do wyszukiwarki - dzięki temu kod nie wykonuje się tak często.
    /// Element .map jako argument przyjmuje poniższą funkcję filtrującą.
    /// Element .store - przechowuje subskrybcje w zmiennej cancellables.
    /// Używam tutaj odwołania do Publisher'ów w serwisach, a nie zmiennych oznaczonych jako @Published ponieważ mock'uje oryginalne serwisy przy pomocy zgodności z danym protokołem. Wtedy w protokole trzeba dodać jeszcze Publisher'a, który będzie publikował zmiany dla zmiennej oznaczonej jako @Published. W protokole nie jesteśmy w stanie oznaczyć zmiennej jako @Published, natomiast możemy dać wymóg, że dany serwis zgodny z protokołem musi posiadać Publisher'a.
    func addSubscribers() {
        
        // For update all coins
        $searchText
            .combineLatest(coinDataService.allCoinsPublisher, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // For update portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.savedEntitiesPublisher)
            .map(mapAllCoinsToPorfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // For update market data
        $portfolioCoins
            .combineLatest(marketDataService.marketDataPublisher)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    /// Metoda aktualizuje dane dla portfolio użytkownika.
    /// Używamy w tym celu metody zdefiniowanej w portfolio data service.
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    /// Metoda pozwala na odświeżenie danych w aplikacji.
    /// Pobieramy raz jeszcze dane z api dla coins oraz market data.
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    /// Metoda modyfikuje dane które otrzymujemy podczas subskrybowania zmiennych dla portfolio coins.
    private func mapAllCoinsToPorfolioCoins(coins: [Coin], entities: [PortfolioEntity]) -> [Coin] {
        return coins
            .compactMap { (coin) -> Coin? in
                guard let entity = entities.first(where: { $0.coinID == coin.id }) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    /// Metoda modyfikuje dane które otrzymujemy podczas subskrybowania zmiennych dla market data.
    private func mapGlobalMarketData(portfolioCoins: [Coin], data: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data else {
            return stats
        }
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24hUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)
        let previousValue = portfolioCoins
            .map(mapPortfolioCoinsToPreviousValue)
            .reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        let portfolio = Statistic(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }
    
    /// Metoda modyfikuje dane znajdujące się w portfolio coins i zwraca poprzednią wartość (sprzed 24h) danego coina.
    private func mapPortfolioCoinsToPreviousValue(coin: Coin) -> Double {
        let currentValue = coin.currentHoldingsValue
        let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
        let previousValue = currentValue / (1 + percentChange)
        return previousValue
    }
    
    /// Metoda modyfikuje i sortuje dane które otrzymujemy podczas subskrybowania zmiennych dla all coins.
    private func filterAndSortCoins(text: String, coins: [Coin], sort: SortOption) -> [Coin] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(coins: &updatedCoins, sort: sort)
        return updatedCoins
    }
    
    /// Metoda filtruje wszystkie coiny zgodne z wpisanym przez usera tekstem.
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
    
    /// Metoda sortuje wszystkie coiny w zależności od wybranego typu sortowania.
    private func sortCoins(coins: inout [Coin], sort: SortOption) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    /// Metoda sortuje portfolio coins jeśli jest to potrzebne.
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
}
