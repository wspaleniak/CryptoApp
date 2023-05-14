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
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    // MARK: Metoda dodająca subskrybowanie
    // dodajemy obserwowanie tablicy allCoins
    // tablica znajduje się w klasie CoinDataService
    // za każdym razem gdy zmieni się jej wartość, przypisujemy ją do tablicy allCoins zdefiniowanej w klasie HomeViewModel
    // .store - przechowuje subskrybcje w zmiennej cancellables
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
