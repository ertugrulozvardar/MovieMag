//
//  Crew.swift
//  MovieMag
//
//  Created by obss on 2.06.2022.
//

import Foundation

struct Crew: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let known_for_department: String?
    let name: String?
    let original_name: String?
    let popularity: Float?
    let profile_path: String?
    let credit_id: String?
    let department: String?
    let job: String?

    var profileURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profile_path ?? "")")!
    }
}
