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

    func configure(recommendedMovie: Movie) {
        recommendedMovieImageView.kf.setImage(with: recommendedMovie.posterURL)
    }
}
