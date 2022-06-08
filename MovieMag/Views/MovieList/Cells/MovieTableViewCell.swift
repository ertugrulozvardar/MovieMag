//
//  MovieTableViewCell.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    private var status: Bool = false
    private var statusMovie: Movie?
    public var remover: Bool = false
    
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var addFavoriteIcon: UIButton!
    @IBOutlet weak var addFavoritesButton: UIStackView!
    private var favoriteMovies = [Movie]()
    
    var movie: Movie?
    let userDefaults = UserDefaults.standard
    
    func configure(movie: Movie) {
        self.movie = movie
        movieImageView.kf.setImage(with: movie.posterURL)
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        movieRatingLabel.text = movie.ratingText    
    }
    
    func saveToFavorites() {
            if let getFavMovies = userDefaults.data(forKey: "FavoriteMovies") {
                favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: getFavMovies)
                favoriteMovies.append(movie!)
                if let setFavMovies = try? PropertyListEncoder().encode(favoriteMovies) {
                    userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
                }
            } else {
                let array = [movie!]
                if let setFavMovies = try? PropertyListEncoder().encode(array) {
                    userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
                }
            }
    }
    
    @IBAction func addFavoriteButtonPressed(_ sender: UIButton) {
        if addFavoriteIcon.currentImage == UIImage(systemName: "star") {
            addFavoriteIcon.setImage(UIImage(systemName: "star.fill"), for: .normal)
            saveToFavorites()
        } else {
            addFavoriteIcon.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
