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
    
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            updateFavoritesIcon()
        }
    }
    
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieAdditionalInformationLabel: UILabel!
    @IBOutlet weak var movieBudgetLabel: UILabel!
    @IBOutlet weak var movieOriginalLanguageLabel: UILabel!
    @IBOutlet weak var movieOriginalTitleLabel: UILabel!
    @IBOutlet weak var movieRevenueLabel: UILabel!
    @IBOutlet weak var movieProductionCompaniesLabel: UILabel!
    @IBOutlet weak var movieHomepageLabel: UILabel!
    @IBOutlet weak var movieRecommendationsLabel: UILabel!
    @IBOutlet weak var movieCastLabel: UILabel!
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
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    
    var movieId: Int?
    var movie: Movie?
    var dataManager = DataManager()
    var notificationCenter = NotificationCenter.default
    var alertManager = AlertManager()
    private let movieService: MovieServiceProtocol = MovieService()
    private let castService: CastServiceProtocol = CastService()
    private let recommendationService: RecommendationServiceProtocol = RecommendationService()
    private var movieDetail: MovieDetail?
    private var recommendedMovies: [Movie] = []
    private var castMembers: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNotificationRequest()
        localizeLabelTexts()
        registerCollectionCells()
        getMovieDetail()
        getRecommendations()
        getCastMembers()
    }
    
    func registerCollectionCells() {
        recommendationsCollectionView.register(UINib(nibName: RecommendationCollectionViewCell.reuseIdentifierString, bundle: nil), forCellWithReuseIdentifier: RecommendationCollectionViewCell.reuseIdentifierString)
        castCollectionView.register(UINib(nibName: CastCollectionViewCell.reuseIdentifierString, bundle: nil), forCellWithReuseIdentifier: CastCollectionViewCell.reuseIdentifierString)
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
            if let currentNavigationController = self.navigationController {
                alertManager.createAlertForServices(navigationController: currentNavigationController, viewController: self)
            }
        }
    }
    
    func getRecommendations() {
        if let id = movieId {
            recommendationService.fetchRecommendations(id: id) { result in
                switch result {
                case .success(let response):
                    self.recommendedMovies = response.results ?? []
                    self.recommendationsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            if let currentNavigationController = self.navigationController {
                alertManager.createAlertForServices(navigationController: currentNavigationController, viewController: self)
            }
        }
    }
    
    func getCastMembers() {
        if let id = movieId {
            castService.fetchCasts(id: id) { result in
                switch result {
                case .success(let response):
                    self.castMembers = response.cast ?? []
                    self.castCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            if let currentNavigationController = self.navigationController {
                alertManager.createAlertForServices(navigationController: currentNavigationController, viewController: self)
            }
        }
    }
    
    func localizeLabelTexts() {
        movieOverviewLabel.text = MovieDetailString.movieOverviewLabel.localized
        movieAdditionalInformationLabel.text = MovieDetailString.movieAdditionalInformationLabel.localized
        movieBudgetLabel.text = MovieDetailString.movieBudgetLabel.localized
        movieOriginalLanguageLabel.text = MovieDetailString.movieOriginalLanguageLabel.localized
        movieOriginalTitleLabel.text = MovieDetailString.movieOriginalTitleLabel.localized
        movieRevenueLabel.text = MovieDetailString.movieRevenueLabel.localized
        movieProductionCompaniesLabel.text = MovieDetailString.movieProductionCompaniesLabel.localized
        movieHomepageLabel.text = MovieDetailString.movieHomepageLabel.localized
        movieRecommendationsLabel.text = MovieDetailString.movieRecommendationsLabel.localized
        movieCastLabel.text = MovieDetailString.movieCastLabel.localized
        homepageButton.setTitle(MovieDetailString.homepageButton.localized, for: .normal)
    }
    
    @IBAction func homepageButtonPressed(_ sender: UIButton) {
        if let currentHomepage = movieDetail?.homepage {
            directToURL(url: currentHomepage)
        } else {
            if let currentNavigationController = self.navigationController {
                alertManager.createAlertForAddingFavorites(navigationController: currentNavigationController, viewController: self)
            }
            
        }
        
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
        productionCompaniesLabel.text = movieDetail.productionCompanies?.getProductionCompaniesText()
        overviewLabel.text = movieDetail.overview
    }
    
    @IBAction func addToFavoritesPressed(_ sender: UIButton) {
        if let currentMovie = movie {
            if !dataManager.isInFavorites(movie: currentMovie) {
                dataManager.saveToFavorites(movie: currentMovie)
                if let currentNavigationController = self.navigationController {
                    alertManager.createAlertForAddingFavorites(navigationController: currentNavigationController, viewController: self)
                }
                addToFavoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                
            } else {
                if let currentMovie = movie {
                    dataManager.removeFromfavorites(movie: currentMovie)
                    if let currentNavigationController = self.navigationController {
                        alertManager.createAlertForRemovingFavorites(navigationController: currentNavigationController, viewController: self)
                    }
                    addToFavoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
                }
            }
        }
        notificationCenter.post(name: Notification.Name("MovieRemoved"), object: nil)
    }
    
    func updateFavoritesIcon() {
        adjustFavoriteIcon()
    }
    
    @objc func movieChanged() {
        adjustFavoriteIcon()
    }
    
    func makeNotificationRequest() {
        notificationCenter.addObserver(self, selector: #selector(movieChanged), name: Notification.Name("MovieRemoved"), object: nil)
    }
    
    func adjustFavoriteIcon() {
        if let currentMovie = movie {
            if dataManager.isInFavorites(movie: currentMovie) {
                addToFavoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                addToFavoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
}
//MARK: -UICollectionView Methods
extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case recommendationsCollectionView:
            return recommendedMovies.count
        case castCollectionView:
            return castMembers.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case recommendationsCollectionView:
            let recommendationsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCollectionViewCell" , for: indexPath) as! RecommendationCollectionViewCell
            let recommendedMovie: Movie
            recommendedMovie = recommendedMovies[indexPath.row]
            recommendationsCell.configure(recommendedMovie: recommendedMovie)
            return recommendationsCell
        case castCollectionView:
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
        if collectionView == castCollectionView {
            if let castDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CastDetailViewController.self)) as? CastDetailViewController {
                
                castDetailsVC.castId = castMembers[indexPath.row].id
                self.navigationController?.pushViewController(castDetailsVC, animated: true)
            }
        } else {
            if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
                
                let recommendedMovie = recommendedMovies[indexPath.row]
                movieDetailsVC.movieId = recommendedMovie.id
                movieDetailsVC.movie = 	recommendedMovie
                self.navigationController?.pushViewController(movieDetailsVC, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == castCollectionView {
            return CGSize(width: 280, height: 90)
        } else {
            return CGSize(width: 100, height: 150)
        }
        
    }
}
