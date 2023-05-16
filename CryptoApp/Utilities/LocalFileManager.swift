//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 16/05/2023.
//

import SwiftUI

// MARK: Miejsce zapisywania ikonek
// Tutaj zapisujemy ikonki dla każdego coina, aby nie musieć ich cały czas pobierać z linku
class LocalFileManager {
    
    static let shared = LocalFileManager()
    private init() { }
    
    /// Metoda zapisuje przekazane zdjęcie o podanej nazwie w folderze o podanej nazwie.
    func saveImage(_ image: UIImage, imageName: String, folderName: String) {
        /// tworzenie folderu
        createFolderIfNeeded(folderName: folderName)
        /// pobieramy ścieżkę dla zdjęcia
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        /// zapisujemy zdjecie na pobranej ścieżce
        do {
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error.localizedDescription); Image name: \(imageName)")
        }
    }
    
    /// Metoda pobiera zdjęcie o podanej nazwie z folderu o podanej nazwie.
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    /// Metoda tworzy folder, jeśli folder o podanej nazwie jeszcze nie istnieje.
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print("Error creating directory: \(error.localizedDescription); Folder name: \(folderName)")
            }
        }
    }
    
    /// Metoda tworzy URL dla poszczególnego zdjęcia.
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
    /// Metoda tworzy URL dla folderu przechowującego zdjęcia.
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
}
