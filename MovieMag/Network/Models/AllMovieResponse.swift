//
//  AllMovieResponse.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import Foundation

struct AllMovieResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let total_pages: Int?
    let total_results: Int?
}
