//
//  CastDetailViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class CastDetailViewController: UIViewController {

    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorBirthdayLabel: UILabel!
    @IBOutlet weak var actorBirthPlaceLabel: UILabel!
    @IBOutlet weak var actorDeathDayLabel: UILabel!
    @IBOutlet weak var actorBiographyLabel: UILabel!
    
    var castId: Int?
    private var castDetail: CastDetail?
    private let movieService: MovieServiceProtocol = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCastDetail()
        
    }
    
    func getCastDetail() {
        if let castId = castId {
            movieService.fetchSingleCast(castId: castId) { result in
                switch result {
                case .success(let response):
                    self.castDetail = response
                    self.updateUIElements(castDetail: self.castDetail!)
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
    
    func updateUIElements(castDetail: CastDetail) {
        actorImageView.kf.setImage(with: castDetail.profileURL)
        actorNameLabel.text = castDetail.name
        actorBirthdayLabel.text = castDetail.birthday
        actorBirthPlaceLabel.text = castDetail.place_of_birth
        if let deathDayInfo = castDetail.deathday {
            actorDeathDayLabel.text = deathDayInfo
        } else {
            actorDeathDayLabel.text = "Alive"
        }
        actorBiographyLabel.text = castDetail.biography
    }

}
