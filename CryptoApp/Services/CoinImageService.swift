//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 19/04/2023.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinImage(coin: coin)
    }
    
    private func getCoinImage(coin: Coin) {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager
            .download(url: url)
            .tryMap { (data) -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: NetworkManager.handleCompletion) { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            }
    }
}
