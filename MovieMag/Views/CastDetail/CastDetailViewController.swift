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
    let currentLanguage = Locale.current.languageCode
    
    var castId: Int?
    private var castDetail: CastDetail?
    private let movieService: MovieServiceProtocol = MovieService()
    private let castService: CastServiceProtocol = CastService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCastDetail()
        
    }
    
    func getCastDetail() {
        if let castId = castId {
            castService.fetchSingleCast(castId: castId) { result in
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
        actorBirthdayLabel.text = castDetail.birthdayText
        actorBirthPlaceLabel.text = castDetail.placeOfBirth
        if let deathDayInfo = castDetail.deathdayText {
            actorDeathDayLabel.text = deathDayInfo
        } else {
            if currentLanguage == "en" {
                actorDeathDayLabel.text = "Alive"
            } else {
                actorDeathDayLabel.text = "Yaşıyor"
            }
            
        }
        actorBiographyLabel.text = castDetail.biography
    }

}
