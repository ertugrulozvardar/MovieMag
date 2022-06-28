//
//  CastDetailString.swift
//  MovieMag
//
//  Created by pc on 28.06.2022.
//

import Foundation

enum CastDetailString: String {
    case castBirthdayLabel
    case castBirthplaceLabel
    case castDeathdayLabel
    case castBiographyLabel
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
