//
//  Movie.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import Foundation

struct Movie: Codable {

    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
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
    
    var scoreText: String {
        return modelFormatter.formatScore(with: ratingText)
    }
    
    var yearText: String {
        let dateFormatter = modelFormatter.formatDate()
        guard let releaseDate = self.releaseDate, let date = dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return modelFormatter.formatDateByYear(with: date)
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool{
        return lhs.id == rhs.id
    }
}


