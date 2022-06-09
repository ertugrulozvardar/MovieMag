//
//  MovieGenre.swift
//  MovieMag
//
//  Created by obss on 2.06.2022.
//

import Foundation

struct MovieGenre: Codable {
    let id: Int?
    let name: String?
}

extension Collection where Iterator.Element == MovieGenre {
    func getGenresText() -> String {
        guard !self.isEmpty else { return "-"}
        
        let names = self.compactMap { MovieGenre in
            MovieGenre.name
        }
        return names.joined(separator: ", ")
    }
}
