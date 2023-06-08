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
    
    @Published var searchText: String = ""
    
    private let dataService: CoinDataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: CoinDataServiceProtocol) {
        self.dataService = dataService
        addSubscribers()
    }
    
    // MARK: Metoda dodająca subskrybowanie wybranych zmiennych
    /// Dodajemy jednoczesne obserwowanie wpisywanego w wyszukiwarkę tekstu oraz tablicy allCoins (poprzez jej Publishera).
    /// Za każdym razem gdy zmieni się wartość wpisywanego tekstu lub tablicy, wykonujemy poniższą logikę.
    /// Używamy .debounce(for:scheduler:) aby dodać lekkie opóźnienie, gdy użytkownik, bardzo szybko wpisuje frazy do wyszukiwarki - dzięki temu kod nie wykonuje się tak często.
    /// Element .map jako argument przyjmuje poniższą funkcję filtrującą.
    /// Element .store - przechowuje subskrybcje w zmiennej cancellables.
    func addSubscribers() {
        $searchText
            .combineLatest(dataService.allCoinsPublisher)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
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
