//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 09/06/2023.
//

import Foundation
import Combine

// MARK: - Protocol
protocol MarketDataServiceProtocol {
    var marketData: MarketData? { get set }
    var marketDataPublisher: Published<MarketData?>.Publisher { get }
    func getMarketData()
}

// MARK: - Class
class MarketDataService: MarketDataServiceProtocol {
    
    @Published var marketData: MarketData? = nil
    var marketDataPublisher: Published<MarketData?>.Publisher { $marketData }
    var marketDataSubscribtion: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        let urlString = "https://api.coingecko.com/api/v3/global"
        guard let url = URL(string: urlString) else { return }
        
        marketDataSubscribtion = NetworkManager
            .download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscribtion?.cancel()
            })
    }
}

// MARK: - Mock
class MockMarketDataService: MarketDataServiceProtocol {
    
    @Published var marketData: MarketData? = nil
    var marketDataPublisher: Published<MarketData?>.Publisher { $marketData }
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.marketData = DeveloperPreview.shared.globalData.data
        }
    }
}
