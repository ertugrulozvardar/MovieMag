//
//  MovieDetail.swift
//  MovieMag
//
//  Created by obss on 3.06.2022.
//

import Foundation

struct MovieDetail: Codable {

    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [MovieGenre]?
    let homepage: String?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    private let modelFormatter = ModelFormatter()
    
    var backdropURL: URL {
        return modelFormatter.getBackdropUrl(by: backdropPath)
    }
    
    var posterURL: URL {
        return modelFormatter.getPosterUrl(by: posterPath)
    }
    
    var ratingText: String {
        return modelFormatter.formatRating(with: voteAverage ?? 0)
    }
    
    var budgetText: String {
        return "\(budget ?? 0)"
    }
    
    var revenueText: String {
        return "\(revenue ?? 0)"
    }
    
    var scoreText: String {
        return modelFormatter.formatScore(with: ratingText)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return modelFormatter.formatDuration(with: runtime)
    }
    
    var yearText: String {
        let dateFormatter = modelFormatter.formatDate()
        guard let releaseDate = self.releaseDate, let date = dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return modelFormatter.formatDateByYear(with: date)
    }
    
}

