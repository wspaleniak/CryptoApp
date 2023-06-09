//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 08/04/2023.
//

import Foundation
import Combine

// MARK: - Protocol
protocol CoinDataServiceProtocol {
    var allCoins: [Coin] { get set }
    var allCoinsPublisher: Published<[Coin]>.Publisher { get }
    func getCoins()
}

// MARK: - Class
class CoinDataService: CoinDataServiceProtocol {
    
    @Published var allCoins: [Coin] = []
    var allCoinsPublisher: Published<[Coin]>.Publisher { $allCoins }
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    // MARK: Metoda do pobierania danych z API przy pomocy NetworkManager
    /// Dekoduje na typ [Coin].self.
    /// Pobraną wartość przypisuje do allCoins.
    /// Dodajemy receive(on:) aby działało dobrze cancel'owanie subskrybcji.
    func getCoins() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en"
        guard let url = URL(string: urlString) else { return }
        
        coinSubscription = NetworkManager
            .download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion) { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}

// MARK: - Mock
/// Aby móc mockować elementy w PreviewProvider.
class MockCoinDataService: CoinDataServiceProtocol {
    
    @Published var allCoins: [Coin] = []
    var allCoinsPublisher: Published<[Coin]>.Publisher { $allCoins }
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.allCoins.append(DeveloperPreview.shared.bitcoin)
            self?.allCoins.append(DeveloperPreview.shared.ethereum)
            self?.allCoins.append(DeveloperPreview.shared.tether)
        }
    }
}
