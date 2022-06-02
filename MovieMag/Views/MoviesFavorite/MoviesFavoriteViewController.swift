//
//  MovieListViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class MoviesFavoriteViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    private var favoriteMovies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
    }
    
    func configureTableView() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    func getFavorites() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "FavoriteMovies") {
            favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: data)
        }
    }
}

//MARK: -TableView Delegate & DataSource Methods
extension MoviesFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell

        let movie = favoriteMovies[indexPath.row]
        cell.configure(movie: movie)
        return cell
        }
        
}


