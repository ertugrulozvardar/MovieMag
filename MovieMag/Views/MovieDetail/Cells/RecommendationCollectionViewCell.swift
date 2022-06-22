//
//  RecommendationCollectionViewCell.swift
//  MovieMag
//
//  Created by pc on 7.06.2022.
//

import UIKit
import Kingfisher

class RecommendationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recommendedMovieImageView: UIImageView!
    
    var recommendedMovie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(recommendedMovie: Movie) {
        self.recommendedMovie = recommendedMovie
        recommendedMovieImageView.kf.setImage(with: recommendedMovie.posterURL)
    }

}
