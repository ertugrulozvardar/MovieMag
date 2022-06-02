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

    private var movies: [Movie] = []
    private var filteredMovies = [Movie]()
    private var isFilterActive = false
    public var favoriteMovies = [Movie]()
    private var currentPage = 1
    private var isFetchingMovies = false
    private let movieService: MovieServiceProtocol = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
        fetchMovies()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    func initSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        self.tableView.tableHeaderView = searchBar
    }
        
    func fetchMovies() {
        isFetchingMovies = true
        movieService.fetchAllMovies(atPage: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies.append(contentsOf: response.results!)
                self?.tableView.reloadData()
                self?.currentPage += 1
                self?.isFetchingMovies = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: -TableView Delegate & DataSource Methods
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if isFilterActive {
                return filteredMovies.count
            } else {
                return movies.count
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell

        let movie: Movie
            if isFilterActive {
                movie = filteredMovies[indexPath.row]
            } else {
                movie = movies[indexPath.row]
            }

        cell.configure(movie: movie)
        return cell
        }
}

//MARK: -UITableViewDataSourcePrefetch
extension MovieListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= movies.count - 3 && !isFetchingMovies {
                fetchMovies()
                break
            }
        }
    }
}
//MARK: -SearchBar Delegate Methods
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            fetchMovies()
        }
        else {
            filteredMovies = movies.filter({ movie in
                return movie.title.range(of: searchText, options: [ .caseInsensitive ]) != nil
            })
        }
        isFilterActive = true
        self.tableView.reloadData()
    }
}
