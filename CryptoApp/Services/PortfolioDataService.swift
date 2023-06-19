//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 19/06/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private enum Constants {
        static let containerName: String = "PortfolioContainer"
        static let entityName: String = "PortfolioEntity"
    }
    
    @Published var savedEntities: [PortfolioEntity] = []
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: Constants.containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading CoreData: \(error.localizedDescription)")
            }
            self.getPortfolio()
        }
    }
    
    /// Metoda publiczna, która pozwala wykorzystać poniżej zaimplementowane metody.
    func updatePortfolio(coin: Coin, amount: Double) {
        // Sprawdzamy czy dany coin znajduję się już w CoreData.
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                // Jeśli jest taki coin i jego ilość jest większa od 0 to robimy update.
                update(entity: entity, amount: amount)
            } else {
                // Jeśli jest taki coin, ale obecnie mamy go w ilości 0 to usuwamy.
                delete(entity: entity)
            }
        } else {
            // Jeśli nie ma takiego coina to dodajemy do CoreData.
            add(coin: coin, amount: amount)
        }
    }
    
    /// Metoda pozwala pobrać elementy zapisane w CoreData.
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: Constants.entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching Portfolio Entities: \(error.localizedDescription)")
        }
    }
    
    /// Metoda pozwala dodać nowe elementy do CoreData.
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    /// Metoda pozwala uaktualnić istniejące dane z CoreData.
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    /// Metoda pozwala na usunięcie danych z CoreData.
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to CoreData: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
