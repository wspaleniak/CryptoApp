//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 08/04/2023.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    // MARK: Metoda do pobierania danych z API przy pomocy NetworkManager
    // dekoduje na typ [Coin].self
    // pobraną wartość przypisuje do allCoins
    private func getCoins() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en"
        guard let url = URL(string: urlString) else { return }
        
        coinSubscription = NetworkManager
            .download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion) { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}
