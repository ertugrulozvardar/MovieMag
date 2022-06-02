//
//  MovieTableViewCell.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    private var favoriteMovies = [Movie]()
    private var status: Bool = false
    private var statusMovie: Movie?
    
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var addFavoriteIcon: UIButton!
    
    func configure(movie: Movie) {
        movieImageView.kf.setImage(with: movie.posterURL)
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        movieRatingLabel.text = movie.ratingText    
    }
    func saveToFavorites(movie: Movie) {
        favoriteMovies.append(movie)
        let userDefaults = UserDefaults.standard
        if let data = try? PropertyListEncoder().encode(favoriteMovies) {
            userDefaults.set(data, forKey: "FavoriteMovies")
        }
    }
    
    func changeStatus(movie: Movie) {
        status = true
        statusMovie = movie
        
    }
    
    @IBAction func addFavoritePressed(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: "star") {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            if status {
                saveToFavorites(movie: statusMovie!)
            }
        } else {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
