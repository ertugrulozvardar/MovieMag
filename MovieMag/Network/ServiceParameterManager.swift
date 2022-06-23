//
//  serviceParameterManager.swift
//  MovieMag
//
//  Created by pc on 23.06.2022.
//

import Foundation

struct ServiceParameterManager {
    private let apiKey = "2a688e11aac3f4d3278cc7ed05a281ec"
    private let baseUrl = "https://api.themoviedb.org/"
    private let baseParameter = 3
    
    func getApiKey() -> String? {
        return apiKey
    }
    
    func setBaseUrl () -> String {
        return baseUrl + String(baseParameter)
    }
}
