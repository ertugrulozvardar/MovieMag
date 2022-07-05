//
//  AlertManager.swift
//  MovieMag
//
//  Created by pc on 4.07.2022.
//

import Foundation
import UIKit

struct AlertManager {

    func createAlertForServices(navigationController: UINavigationController, viewController: UIViewController) {
        let alertController = UIAlertController(title: "Hata!", message: "Karakter bulunamadı", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default) { action in
            navigationController.popViewController(animated: true)
        }
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true)
    }
    
    func createAlertForAddingFavorites(navigationController: UINavigationController, viewController: UIViewController) {
        let alertController = UIAlertController(title: "Başarılı!", message: "Film favorilere kaydedildi", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default) { action in
            navigationController.popViewController(animated: true)
        }
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true)
    }
    
    func createAlertForRemovingFavorites(navigationController: UINavigationController, viewController: UIViewController) {
        let alertController = UIAlertController(title: "Başarılı!", message: "Film favorilerden çıkarıldı", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default) { action in
            navigationController.popViewController(animated: true)
        }
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true)
    }
    
    func createAlertForDirectingHomepage(navigationController: UINavigationController, viewController: UIViewController) {
        let alertController = UIAlertController(title: "Hata!", message: "Film linki bulunamadı", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default) { action in
            navigationController.popViewController(animated: true)
        }
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true)
    }
}
