//
//  MovieListViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class MoviesFavoriteViewController: UIViewController {

    private var favoriteMovies = [Movie]()
    let userDefaults = UserDefaults.standard
    let notificationCenter = NotificationCenter.default
    private var dataManager = DataManager()
    
    @IBOutlet weak var favoritesTableView: UITableView! {
        didSet {
            configureTableView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavorites()
    }
    
    func configureTableView() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    func getFavorites() {
        if let data = userDefaults.data(forKey: "FavoriteMovies") {
            favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: data)
            favoritesTableView.reloadData()
        }
    }
}

//MARK: -TableView Delegate & DataSource Methods
extension MoviesFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteMovies.count == 0 {
            self.favoritesTableView.setEmptyMessage("No results found")
        } else {
            self.favoritesTableView.restore()
        }
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell
  
        let movie = favoriteMovies[indexPath.row]
        cell.addFavoriteIcon.isHidden = true
        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let getFavMovies = userDefaults.data(forKey: "FavoriteMovies") {
                favoriteMovies = try! PropertyListDecoder().decode([Movie].self, from: getFavMovies)
                favoriteMovies.remove(at: indexPath.row)
                if let setFavMovies = try? PropertyListEncoder().encode(favoriteMovies) {
                    userDefaults.set(setFavMovies, forKey: "FavoriteMovies")
                }
            }
            notificationCenter.post(name: Notification.Name("MovieRemoved"), object: nil)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            movieDetailsVC.movieId = favoriteMovies[indexPath.row].id
            self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}



