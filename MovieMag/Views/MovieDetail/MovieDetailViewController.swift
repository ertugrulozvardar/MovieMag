//
//  MovieDetailViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var productionCompaniesLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieId: Int?
    private let movieService: MovieServiceProtocol = MovieService()
    private var movieDetail: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = movieId {
            movieService.fetchMovie(id: id) { result in
                switch result {
                case .success(let response):
                    self.movieDetail = response
                    self.updateUIElements(movieDetail: self.movieDetail!)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let alertController = UIAlertController(title: "Hata!", message: "Karakter bulunamadı", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Tamam", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okButton)
            self.present(alertController, animated: true)
        }
    }
    
    
    func updateUIElements(movieDetail: MovieDetail) {
        movieImageView.kf.setImage(with: movieDetail.posterURL)
        movieNameLabel.text = movieDetail.title
        releaseDateLabel.text = movieDetail.release_date
        durationLabel.text = movieDetail.durationText
        originalTitleLabel.text = movieDetail.original_title
        //originalLanguageLabel.text = movie.original_language
        ratingLabel.text = movieDetail.ratingText
        genresLabel.text = movieDetail.genreText
        budgetLabel.text = movieDetail.budgetText
        revenueLabel.text = movieDetail.revenueText
        //productionCompaniesLabel.text = movies.first?.pr
        homepageLabel.text = movieDetail.homepage
        overviewLabel.text = movieDetail.overview
    }
}
    
