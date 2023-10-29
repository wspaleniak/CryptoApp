//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 28/06/2023.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    // Coin
    @Published var coin: Coin
    
    // Overview statistics
    @Published var overviewStatistics: [Statistic] = []
    
    // Additional statistics
    @Published var additionalStatistics: [Statistic] = []
    
    // Coin description and urls
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    // Services
    private let coinDetailDataService: CoinDetailDataServiceProtocol
    
    // Store subscribers
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin, coinDetailDataService: CoinDetailDataServiceProtocol) {
        self.coin = coin
        self.coinDetailDataService = coinDetailDataService
        addSubscribers()
    }
    
    /// Metoda dodająca subskrybowanie wybranych zmiennych.
    func addSubscribers() {
        coinDetailDataService.coinDetailPublisher
            .combineLatest($coin)
            .map(mapDataToStats)
            .sink { [weak self] (overview, additional) in
                self?.overviewStatistics = overview
                self?.additionalStatistics = additional
            }
            .store(in: &cancellables)
        
        coinDetailDataService.coinDetailPublisher
            .sink { [weak self] coinDeitails in
                self?.coinDescription = coinDeitails?.readableDescription
                self?.websiteURL = coinDeitails?.links?.homepage?.first
                self?.redditURL = coinDeitails?.links?.subredditUrl
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStats(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        let overviewArray = createOverviewArray(coin: coin)
        let additionalArray = createAdditionalArray(coinDetail: coinDetail, coin: coin)
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(
            title: "Current Price",
            value: price,
            percentageChange: pricePercentChange
        )
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(
            title: "Market Capitalization",
            value: marketCap,
            percentageChange: marketCapPercentChange
        )
        let rank = "\(coin.rank)"
        let rankStat = Statistic(
            title: "Rank",
            value: rank
        )
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(
            title: "Volume",
            value: volume
        )
        return [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
    }
    
    private func createAdditionalArray(coinDetail: CoinDetail?, coin: Coin) -> [Statistic] {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(
            title: "24h High",
            value: high
        )
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(
            title: "24h Low",
            value: low
        )
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(
            title: "24h Price Change",
            value: priceChange,
            percentageChange: pricePercentChange
        )
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(
            title: "Market Cap Change",
            value: marketCapChange,
            percentageChange: marketCapPercentChange
        )
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(
            title: "Block Time",
            value: blockTimeString
        )
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(
            title: "Hashing Algorithm",
            value: hashing
        )
        return [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
    }
}
