//
//  MovieDetailStrings.swift
//  MovieMag
//
//  Created by pc on 28.06.2022.
//

import Foundation

enum MovieDetailString: String {
    case movieOverviewLabel
    case movieAdditionalInformationLabel
    case movieBudgetLabel
    case movieOriginalLanguageLabel
    case movieOriginalTitleLabel
    case movieRevenueLabel
    case movieProductionCompaniesLabel
    case movieHomepageLabel
    case movieRecommendationsLabel
    case movieCastLabel
    case homepageButton
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
