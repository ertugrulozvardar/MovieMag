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
    
    mutating func isInFavorites(movie: Movie) -> Bool {
        if let getFavMovies = userDefaults.data(forKey: "FavoriteMovies") {
            favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: getFavMovies)
        }
        if favoriteMovies.contains(movie) {
            return true
        } else {
            return false
        }
    }
        
    mutating func saveToFavorites(movie: Movie) {
        favoriteMovies.append(movie)
        if let setFavMovies = try? PropertyListEncoder().encode(favoriteMovies) {
            userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
        } else {
            let newFavoriteMovies = [movie]
            if let setFavMovies = try? PropertyListEncoder().encode(newFavoriteMovies) {
                userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
            }
        }
    }
    
    mutating func delete(movieToRemove: Movie) {
        for movie in favoriteMovies {
            if movie == movieToRemove {
                favoriteMovies.remove(at: favoriteMovies.firstIndex(of: movieToRemove)!)
            }
        }
    }
    
    mutating func removeFromfavorites(movie: Movie) {
        if let getFavMovies = userDefaults.data(forKey: "FavoriteMovies") {
            favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: getFavMovies)
            delete(movieToRemove: movie)
            if let setFavMovies = try? PropertyListEncoder().encode(favoriteMovies) {
                userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
            }
        }
    }
}

