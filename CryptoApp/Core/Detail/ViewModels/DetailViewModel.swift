//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 28/06/2023.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    // Coin detail
    @Published var coinDetail: CoinDetail? = nil
    
    // Services
    private let coinDetailDataService: CoinDetailDataServiceProtocol
    
    // Store subscribers
    private var cancellables = Set<AnyCancellable>()
    
    init(coinDetailDataService: CoinDetailDataServiceProtocol) {
        self.coinDetailDataService = coinDetailDataService
        addSubscribers()
    }
    
    /// Metoda dodająca subskrybowanie wybranych zmiennych.
    func addSubscribers() {
        coinDetailDataService.coinDetailPublisher
            .sink { [weak self] returnedCoinDetail in
                self?.coinDetail = returnedCoinDetail
            }
            .store(in: &cancellables)
    }
}
