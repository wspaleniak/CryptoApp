//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 08/04/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    private let dataService: CoinDataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: CoinDataServiceProtocol) {
        self.dataService = dataService
        addSubscribers()
    }
    
    // MARK: Metoda dodająca subskrybowanie
    /// Dodajemy obserwowanie tablicy allCoins.
    /// Tablica znajduje się w klasie CoinDataService.
    /// Za każdym razem gdy zmieni się jej wartość, przypisujemy ją do tablicy allCoins zdefiniowanej w klasie HomeViewModel.
    /// Element .store - przechowuje subskrybcje w zmiennej cancellables.
    func addSubscribers() {
        dataService.allCoinsPublisher
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
