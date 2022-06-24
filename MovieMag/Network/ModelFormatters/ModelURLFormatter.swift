//
//  ModelURLFormatter.swift
//  MovieMag
//
//  Created by pc on 24.06.2022.
//

import Foundation

struct ModelURLFormatter {
    
    private let baseUrl = "https://image.tmdb.org/"
    private let baseParameter = "t/p/w500"
    
    func setBaseUrl () -> String {
        return baseUrl + String(baseParameter)
    }
    
    func getBackdropUrl(by backdropPath: String?) -> URL {
        return URL(string: "\(setBaseUrl())\(backdropPath ?? "")")!
    }
    
    func getPosterUrl(by posterPath: String?) -> URL {
        return URL(string: "\(setBaseUrl())\(posterPath ?? "")")!
    }
    
    func getProfileUrl(by profilePath: String?) -> URL {
        return URL(string: "\(setBaseUrl())\(profilePath ?? "")")!
    }
}
