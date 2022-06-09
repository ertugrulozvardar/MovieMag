//
//  MovieListViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class MoviesFavoriteViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    public var informTableForRemoval: Bool = false
    private var favoriteMovies = [Movie]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFavorites()
        
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.array(forKey: "FavoriteMovies") as? [Movie] else {
            return
        }
        favoriteMovies = data
        favoritesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavorites()
        self.favoritesTableView.reloadData()
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
            favoritesTableView.reloadData()
        }
    }
    
    /*func updateFavoriteMovies(name: String) -> [Movie] {
        guard let movieItems = self.getFavorites else { return [] }
        movieItems = movieItems.filter({ $0.movieItems.name != name})
    }*/
}

//MARK: -TableView Delegate & DataSource Methods
extension MoviesFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell
  
        let movie = favoriteMovies[indexPath.row]
        cell.addFavoriteIcon.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userDefaults = UserDefaults.standard
            favoriteMovies.remove(at: indexPath.row)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            userDefaults.set(favoriteMovies, forKey: "FavoriteMovies")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            movieDetailsVC.movieId = favoriteMovies[indexPath.row].id
            self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
        
}


