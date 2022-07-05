//
//  MovieListViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "AppLogo")
        return imageView
    }()
    
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    lazy var searchVC = UISearchController(searchResultsController: nil)
    private var movies: [Movie] = []
    private var currentPage = 1
    private var isFetchingMovies = false
    private let movieService: MovieServiceProtocol = MovieService()
    private var dataManager = DataManager()
    private var notificationCenter = NotificationCenter.default
    private let userDefaults = UserDefaults.standard
    private var favoriteMovies = [Movie]()
    private var searchMovieTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNotificationRequest()
        view.addSubview(imageView)
        initSearchBar()
        fetchMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.animate()
        }
        destroyAnimationImageView()
    }
    
    var isSearchBarEmpty: Bool {
      return searchVC.searchBar.text?.isEmpty ?? true
    }
    
    private func animate() {
        self.imageView.isHidden = false
        UIView.animate(withDuration: 5, animations: {
            let size = self.view.frame.size.width * 3
            let xDifference = size - self.view.frame.size.width
            let yDifference = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(xDifference/2), y: yDifference/2, width: size, height: size)
        })
    }
    
    private func destroyAnimationImageView() {
        self.imageView.isHidden = false
        UIView.animate(withDuration: 2, delay: 5, options: UIView.AnimationOptions.transitionFlipFromTop) {
            self.imageView.alpha = 0
        } completion: { finished in
            self.imageView.isHidden = true
        }

    }
    
    func configureTableView() {
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        self.moviesTableView.prefetchDataSource = self
        self.moviesTableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    func initSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.searchBar.placeholder = "Search Movies.."
        searchVC.searchBar.delegate = self
    }
        
    func fetchMovies() {
        isFetchingMovies = true
        movieService.fetchAllMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies.append(contentsOf: response.results ?? [])
                    self?.moviesTableView.reloadData()
                    self?.currentPage += 1
                    self?.isFetchingMovies = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchMovies(searchQuery: String) {
        isFetchingMovies = true
        movieService.searchAllMovies(searchQuery: searchQuery) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.results ?? []
                    self?.moviesTableView.reloadData()
                    self?.currentPage += 1
                    self?.isFetchingMovies = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeNotificationRequest() {
        notificationCenter.addObserver(self, selector: #selector(movieChanged), name: Notification.Name("MovieRemoved"), object: nil)
    }
    
    @objc func movieChanged() {
        self.moviesTableView.reloadData()
    }
}
//MARK: -TableView Delegate & DataSource Methods
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count == 0 {
            self.moviesTableView.setEmptyMessage("No results found")
        } else {
            self.moviesTableView.restore()
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell
        let movie: Movie = movies[indexPath.row]
        if dataManager.isInFavorites(movie: movie) {
            cell.addFavoriteIcon.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.addFavoriteIcon.setImage(UIImage(systemName: "star"), for: .normal)
        }
        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            let movie: Movie = movies[indexPath.row]
            movieDetailsVC.movieId = movie.id
            movieDetailsVC.movie = movie
            self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}

//MARK: -UITableViewDataSourcePrefetch
extension MovieListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= movies.count - 1 && !isFetchingMovies {
                fetchMovies()
                break
            }
        }
    }
}
//MARK: -SearchBar Delegate Methods
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if let timer = searchMovieTimer {
            timer.invalidate()
        }
        searchMovieTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.startSearch(_:)), userInfo: text, repeats: false)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        currentPage = 1
        fetchMovies()
    }

    @objc func startSearch(_ timer: Timer) {
        if let searchText = timer.userInfo as? String {
            searchMovies(searchQuery: searchText)
        }
    }
}

//MARK: -TableView Methods
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


