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
    let defaultProfileURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/120px-User-avatar.svg.png")
    let defaultPosterURL = URL(string: "https://www.reelviews.net/resources/img/default_poster.jpg")
    
    
    func setBaseUrl () -> String {
        return baseUrl + String(baseParameter)
    }
    
    func getBackdropUrl(by backdropPath: String?) -> URL {
        return URL(string: "\(setBaseUrl())\(backdropPath ?? "")")!
    }
    
    func getPosterUrl(by posterPath: String?) -> URL {
        if let posterPath = posterPath {
            return URL(string: "\(setBaseUrl())\(posterPath)")!
        } else {
            return defaultPosterURL!
        }
    }
    
    func getProfileUrl(by profilePath: String?) -> URL {
        if let profilePath = profilePath {
            return URL(string: "\(setBaseUrl())\(profilePath)")!
        } else {
            return defaultProfileURL!
        }
    }
}
