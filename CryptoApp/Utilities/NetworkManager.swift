//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 19/04/2023.
//

import Foundation
import Combine

class NetworkManager {
    
    // zestaw błędów, które może zgłosić appka
    enum NetworkError: LocalizedError {
        case badURLResponse(URL)
        case unknown
        
        var errorDescription: String {
            switch self {
            case .badURLResponse(let url):
                return "[🔥] Bad response from url: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
    }
    
    // pobierane są dane z podanego API
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // sprawdza czy response zwraca odpowiedni statusCode
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            print()
            throw NetworkError.badURLResponse(url)
        }
        return output.data
    }
    
    // wyświetla error gdy będzie failure
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
