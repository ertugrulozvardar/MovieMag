//
//  CastDetailViewController.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import UIKit

class CastDetailViewController: UIViewController {

    @IBOutlet weak var castBirthdayLabel: UILabel!
    @IBOutlet weak var castBirthplaceLabel: UILabel!
    @IBOutlet weak var castDeathdayLabel: UILabel!
    @IBOutlet weak var castBiographyLabel: UILabel!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorBirthdayLabel: UILabel!
    @IBOutlet weak var actorBirthPlaceLabel: UILabel!
    @IBOutlet weak var actorDeathDayLabel: UILabel!
    @IBOutlet weak var actorBiographyLabel: UILabel!
    
    var castId: Int?
    private var castDetail: CastDetail?
    private let movieService: MovieServiceProtocol = MovieService()
    private let castService: CastServiceProtocol = CastService()
    private var alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeLabelTexts()
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
            if let currentNavigationController = self.navigationController {
                alertManager.createAlert(alertTitle: MovieDetailString.alertFailureTitle.localized, alertMessage: MovieDetailString.alertForServicesMessage.localized, buttonTitle: MovieDetailString.alertOKTitle.localized, navigationController: currentNavigationController, viewController: self)
            }
        }
    }
    
    func updateUIElements(castDetail: CastDetail) {
        actorImageView.kf.setImage(with: castDetail.profileURL)
        actorNameLabel.text = castDetail.name
        actorBirthdayLabel.text = castDetail.birthdayText
        actorBirthPlaceLabel.text = castDetail.placeOfBirth
        actorBiographyLabel.text = castDetail.biography
        actorDeathDayLabel.text = castDetail.deathdayText
    }
    
    func localizeLabelTexts() {
        castBirthdayLabel.text = CastDetailString.castBirthdayLabel.localized
        castBirthplaceLabel.text = CastDetailString.castBirthplaceLabel.localized
        castDeathdayLabel.text = CastDetailString.castDeathdayLabel.localized
        castBiographyLabel.text = CastDetailString.castBiographyLabel.localized
    }
}
