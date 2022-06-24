//
//  CastDetail.swift
//  MovieMag
//
//  Created by pc on 8.06.2022.
//

import Foundation

struct CastDetail: Codable{
    
    let alsoKnownAs: [String]?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let gender: Int?
    let homepage: String?
    let id: Int?
    let imdbId: String?
    let knownForDepartment: String?
    let name: String?
    let placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case alsoKnownAs = "also_known_as"
        case biography
        case birthday
        case deathday
        case gender
        case homepage
        case id
        case imdbId = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
    
    private let modelURLFormatter = ModelURLFormatter()
    
    var profileURL: URL {
        return modelURLFormatter.getProfileUrl(by: profilePath)
    }
}
