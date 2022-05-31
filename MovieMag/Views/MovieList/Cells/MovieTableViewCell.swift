//
//  MovieTableViewCell.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieFavoriteIcon: UIImageView!
    
    func configure(movie: Movie) {
        movieNameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        movieRatingLabel.text = movie.ratingText    
    }
}
