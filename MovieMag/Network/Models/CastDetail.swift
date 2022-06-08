//
//  CastDetail.swift
//  MovieMag
//
//  Created by pc on 8.06.2022.
//

import Foundation

struct CastDetail {
    
    let also_known_as: [String]?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let gender: Int?
    let homepage: String?
    let id: Int?
    let imdb_id: String?
    let known_for_department: String?
    let name: String?
    let place_of_birth: String?
    let popularity: Double?
    let profile_path: String?
    
    var profileURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(profile_path ?? "")")!
    }
}
