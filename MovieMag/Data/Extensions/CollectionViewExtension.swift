//
//  CollectionViewExtension.swift
//  MovieMag
//
//  Created by pc on 5.07.2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifierString: String {
        return String(describing: self)
    }
}
