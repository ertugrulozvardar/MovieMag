//
//  MovieDetailViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

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
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = movieId {
            movieService.fetchMovie(id: id) { result in
                switch result {
                case .success(let response):
                    self.movies = response.results ?? []
                    self.updateUIElements(movies: self.movies)
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
    
    
    func updateUIElements(movies: [Movie]) {
        movieImageView.kf.setImage(with: movies.first?.posterURL)
        movieNameLabel.text = movies.first?.title
        releaseDateLabel.text = movies.first?.release_date
        durationLabel.text = movies.first?.durationText
        originalTitleLabel.text = movies.first?.original_title
        originalLanguageLabel.text = movies.first?.original_language
        ratingLabel.text = movies.first?.ratingText
        genresLabel.text = movies.first?.genreText
        budgetLabel.text = movies.first?.budgetText
        revenueLabel.text = movies.first?.revenueText
        //productionCompaniesLabel.text = movies.first?.pr
        homepageLabel.text = movies.first?.homepageText
        overviewLabel.text = movies.first?.overview
    }
}
    
