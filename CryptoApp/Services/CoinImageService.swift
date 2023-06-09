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
    
    private let coin: Coin
    private let folderName = "coin_images"
    private let imageName: String
    
    private let fileManager = LocalFileManager.shared
    var imageSubscription: AnyCancellable?
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    /// Metoda zaciąga zdjęcia z lokalnego folderu i przypisuje do obiektu UIImage.
    /// Jeśli w lokalnym folderze jest pusto, to używa metody downloadCoinImage() do pobrania zdjęć z adresu URL.
    private func getCoinImage() {
        if let image = fileManager.getImage(imageName: imageName, folderName: folderName) {
            self.image = image
            print("Zdjęcie pobrane z lokalnego folderu!")
        } else {
            downloadCoinImage()
            print("Downloading image now!")
        }
    }
    
    /// Metoda pobiera zdjęcia coinów z podanego adresu URL.
    /// Następnie zapisuje je w lokalnym folderze przy pomocy obiektu typu LocalFileManager.
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager
            .download(url: url)
            .tryMap { (data) -> UIImage? in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion) { [weak self] returnedImage in
                guard let image = returnedImage,
                      let self else { return }
                self.image = image
                self.fileManager.saveImage(image, imageName: self.imageName, folderName: self.folderName)
                self.imageSubscription?.cancel()
            }
    }
}
