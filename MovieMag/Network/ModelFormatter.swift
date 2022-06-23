//
//  ModelFormatter.swift
//  MovieMag
//
//  Created by pc on 23.06.2022.
//

import Foundation

struct ModelFormatter {
    
    private let baseUrl = "https://image.tmdb.org/"
    private let baseParameter = "t/p/w500"
    
    func setBaseUrl () -> String {
        return baseUrl + String(baseParameter)
    }
    
    func formatDate() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }
    
    func formatDateByYear(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func formatDuration(with runtime: Int) -> String {
        let durationFormatter = DateComponentsFormatter()
        durationFormatter.unitsStyle = .full
        durationFormatter.allowedUnits = [.hour, .minute]
        return durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    func formatRating(with voteAvg: Double) -> String {
        let rating = Int(voteAvg)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    func formatScore(with ratingScore: String) -> String {
        guard ratingScore.count > 0 else {
            return "n/a"
        }
        return "\(ratingScore.count)/10"
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
