//
//  Cast.swift
//  MovieMag
//
//  Created by obss on 2.06.2022.
//

import Foundation

struct Cast: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Float?
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }
    
    private let modelURLFormatter = ModelURLFormatter()
    
    var profileURL: URL {
        return modelURLFormatter.getProfileUrl(by: profilePath)
    }
}
