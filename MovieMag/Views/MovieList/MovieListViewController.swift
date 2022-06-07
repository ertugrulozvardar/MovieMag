//
//  MovieListViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    lazy var searchVC = UISearchController(searchResultsController: nil)
    
    private var movies: [Movie] = []
    private var currentPage = 1
    private var isFetchingMovies = false
    private let movieService: MovieServiceProtocol = MovieService()
    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
        fetchMovies()
    }
    
    func configureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.prefetchDataSource = self
        self.tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    func initSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.searchBar.placeholder = "Search Movies.."
        searchVC.searchBar.delegate = self
    }
        
    func fetchMovies() {
        isFetchingMovies = true
        movieService.fetchAllMovies(atPage: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies.append(contentsOf: response.results ?? [])
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.currentPage += 1
                    self?.isFetchingMovies = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchMovies(searchQuery: String) {
        isFetchingMovies = true
        movieService.searchAllMovies(with: searchQuery) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.results ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.currentPage += 1
                    self?.isFetchingMovies = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
//MARK: -TableView Delegate & DataSource Methods
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell

        let movie: Movie
        movie = movies[indexPath.row]

        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            
            movieDetailsVC.movieId = movies[indexPath.row].id
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        searchMovies(searchQuery: text)
    }
}

