//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 28/06/2023.
//

import Foundation
import Combine

// MARK: - Protocol
protocol CoinDetailDataServiceProtocol {
    var coinDetail: CoinDetail? { get set }
    var coinDetailPublisher: Published<CoinDetail?>.Publisher { get }
    func getCoinDetails()
}

// MARK: - Class
class CoinDetailDataService: CoinDetailDataServiceProtocol {
    
    @Published var coinDetail: CoinDetail? = nil
    var coinDetailPublisher: Published<CoinDetail?>.Publisher { $coinDetail }
    var coinDetailSubscription: AnyCancellable?
    
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        guard let url = URL(string: urlString) else { return }
        
        coinDetailSubscription = NetworkManager
            .download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion) { [weak self] returnedCoinDetail in
                self?.coinDetail = returnedCoinDetail
                self?.coinDetailSubscription?.cancel()
            }
    }
}

// MARK: - Mock
class MockCoinDetailDataService: CoinDetailDataServiceProtocol {
    
    @Published var coinDetail: CoinDetail? = nil
    var coinDetailPublisher: Published<CoinDetail?>.Publisher { $coinDetail }
    
    init() {
        getCoinDetails()
    }
    
    func getCoinDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.coinDetail = DeveloperPreview.shared.bitcoinDetail
        }
    }
}
