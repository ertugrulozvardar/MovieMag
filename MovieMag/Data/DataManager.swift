//
//  DataManager.swift
//  MovieMag
//
//  Created by pc on 17.06.2022.
//

import Foundation
import UIKit

struct DataManager {
    
    private let userDefaults = UserDefaults.standard
    private var favoriteMovies = [Movie]()
    
    mutating func saveToFavorites(movie: Movie) {
            if let getFavMovies = userDefaults.data(forKey: "FavoriteMovies") {
                favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: getFavMovies)
                if !favoriteMovies.contains(movie) { 
                    favoriteMovies.append(movie)
                }
                if let setFavMovies = try? PropertyListEncoder().encode(favoriteMovies) {
                    userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
                }
            } else {
                let newFavoriteMovies = [movie]
                if let setFavMovies = try? PropertyListEncoder().encode(newFavoriteMovies) {
                    userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
                }
            }
    }
}
