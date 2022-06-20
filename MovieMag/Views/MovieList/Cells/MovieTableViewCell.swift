//
//  MovieTableViewCell.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var addFavoriteIcon: UIButton!
    
    var movie: Movie?
    private var dataManager = DataManager()
    
    func configure(movie: Movie) {
        self.movie = movie
        movieImageView.kf.setImage(with: movie.posterURL)
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        movieRatingLabel.text = movie.ratingText    
    }
    
    @IBAction func addToFavoritePressed(_ sender: UIButton) {
        switch addFavoriteIcon.currentImage {
        case UIImage(systemName: "star"):
            addFavoriteIcon.setImage(UIImage(systemName: "star.fill"), for: .normal)
            if let currentMovie = movie {
                dataManager.saveToFavorites(movie: currentMovie)
            }
        default:
            addFavoriteIcon.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
