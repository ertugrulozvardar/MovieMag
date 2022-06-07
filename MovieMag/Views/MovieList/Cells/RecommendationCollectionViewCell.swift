//
//  RecommendationCollectionViewCell.swift
//  MovieMag
//
//  Created by pc on 7.06.2022.
//

import UIKit
import Kingfisher

class RecommendationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recommendationContainerView: UIView!
    @IBOutlet weak var recommendedMovieImageView: UIImageView!
    
    var recommendedMovie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(recommendedMovie: Movie) {
        self.recommendedMovie = recommendedMovie
        recommendedMovieImageView.kf.setImage(with: recommendedMovie.posterURL)
    }

}
