//
//  DataManager.swift
//  MovieMag
//
//  Created by pc on 10.06.2022.
//

import Foundation


struct DataManager {
    private let userDefaults = UserDefaults.standard
    private var favoriteMovies = [Movie]()
    
    mutating func getFavorites() {
        if let data = userDefaults.data(forKey: "FavoriteMovies") {
            favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: data)
        }
    }
}
