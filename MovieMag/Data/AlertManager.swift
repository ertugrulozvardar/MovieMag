//
//  AlertManager.swift
//  MovieMag
//
//  Created by pc on 4.07.2022.
//

import Foundation
import UIKit

struct AlertManager {
    
    func createAlert(alertTitle: String, alertMessage: String, buttonTitle: String, navigationController: UINavigationController, viewController: UIViewController) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: buttonTitle, style: .default) { action in
        }
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true)
    }
}
