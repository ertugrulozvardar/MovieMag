//
//  MovieDetailViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var recommendationsView: UICollectionView!
    
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
    private var recommendedMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetail()
        getRecommendations()
        configureRecommendationCollection()
    }
    
    func configureRecommendationCollection() {
        recommendationsView.register(UINib(nibName: "RecommendationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCollectionViewCell")
    }
    
    func getMovieDetail() {
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
    
    func getRecommendations() {
        if let id = movieId {
            movieService.fetchRecommendations(id: id) { result in
                switch result {
                case .success(let response):
                    self.recommendedMovies = response.results ?? []
                    self.recommendationsView.reloadData()
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
        originalLanguageLabel.text = movieDetail.original_language
        ratingLabel.text = movieDetail.ratingText
        genresLabel.text = movieDetail.genreText
        budgetLabel.text = movieDetail.budgetText
        revenueLabel.text = movieDetail.revenueText
        productionCompaniesLabel.text = movieDetail.production_companies?.first?.name
        homepageLabel.text = movieDetail.homepage
        overviewLabel.text = movieDetail.overview
    }
    
}

//MARK: -UICollectionView Methods
extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCollectionViewCell" , for: indexPath) as! RecommendationCollectionViewCell
        
        let recommendedMovie: Movie
        recommendedMovie = recommendedMovies[indexPath.row]
        cell.configure(recommendedMovie: recommendedMovie)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 2)
    }
}


    
