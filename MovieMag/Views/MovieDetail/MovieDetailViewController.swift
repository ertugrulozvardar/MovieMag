//
//  MovieDetailViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit
import Kingfisher
import SafariServices

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var recommendationsView: UICollectionView! //recommendationsCollectionvİEW
    
    @IBOutlet weak var castView: UICollectionView!
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
    @IBOutlet weak var homepageButton: UIButton!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieId: Int?
    private let movieService: MovieServiceProtocol = MovieService()
    private let castService: CastServiceProtocol = CastService()
    private let recommendationService: RecommendationServiceProtocol = RecommendationService()
    private var movieDetail: MovieDetail?
    private var recommendedMovies: [Movie] = []
    private var castMembers: [Cast] = []
            
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionCells()
        getMovieDetail()
        getRecommendations()
        getCastMembers()
    }
    
    func registerCollectionCells() {
        recommendationsView.register(UINib(nibName: "RecommendationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCollectionViewCell")
        castView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionViewCell")
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
            recommendationService.fetchRecommendations(id: id) { result in
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
    
    func getCastMembers() {
        if let id = movieId {
            castService.fetchCasts(id: id) { result in
                switch result {
                case .success(let response):
                    self.castMembers = response.cast ?? []
                    self.castView.reloadData()
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
    
    @IBAction func homepageButtonPressed(_ sender: UIButton) {
        directToURL(url: movieDetail?.homepage ?? "")
    }
    
    func directToURL(url: String) {
        guard let url = URL(string: url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    func updateUIElements(movieDetail: MovieDetail) {
        movieImageView.kf.setImage(with: movieDetail.posterURL)
        movieNameLabel.text = movieDetail.title
        releaseDateLabel.text = movieDetail.yearText
        durationLabel.text = movieDetail.durationText
        originalTitleLabel.text = movieDetail.originalTitle
        originalLanguageLabel.text = movieDetail.originalLanguage
        ratingLabel.text = movieDetail.ratingText
        genresLabel.text = movieDetail.genres?.getGenresText()
        budgetLabel.text = movieDetail.budgetText
        revenueLabel.text = movieDetail.revenueText
        productionCompaniesLabel.text = movieDetail.productionCompanies?.first?.name
        overviewLabel.text = movieDetail.overview
    }
}

//MARK: -UICollectionView Methods
extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case recommendationsView:
            return recommendedMovies.count
        case castView:
            return castMembers.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case recommendationsView:
            let recommendationsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCollectionViewCell" , for: indexPath) as! RecommendationCollectionViewCell
            let recommendedMovie: Movie
            recommendedMovie = recommendedMovies[indexPath.row]
            recommendationsCell.configure(recommendedMovie: recommendedMovie)
            return recommendationsCell
        case castView:
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell" , for: indexPath) as! CastCollectionViewCell
            let cast: Cast
            cast = castMembers[indexPath.row]
            castCell.configure(cast: cast)
            return castCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == castView {
            if let castDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CastDetailViewController.self)) as? CastDetailViewController {

                castDetailsVC.castId = castMembers[indexPath.row].id
                self.navigationController?.pushViewController(castDetailsVC, animated: true)
            }
        } else {
            if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {

                movieDetailsVC.movieId = recommendedMovies[indexPath.row].id
                self.navigationController?.pushViewController(movieDetailsVC, animated: true)
            }
        }
    }
}
