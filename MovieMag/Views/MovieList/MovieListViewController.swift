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
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
        }
    }

    
    private var movies: [Movie] = []
    private var filteredMovies = [Movie]()
    private var isFilterActive = false
    private let movieService: MovieServiceProtocol = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
        initData()
    }
    
    func initSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        self.tableView.tableHeaderView = searchBar
    }
    
    func initData() {
        movieService.fetchAllMovies { result in
            switch result {
            case .success(let response):
                self.movies = response.results ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
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
//MARK: -SearchBar Delegate Methods
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            initData()
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
