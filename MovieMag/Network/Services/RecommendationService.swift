//
//  RecommendationService.swift
//  MovieMag
//
//  Created by pc on 23.06.2022.
//

import Foundation

protocol RecommendationServiceProtocol {
    func fetchRecommendations(id: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
}

struct RecommendationService: RecommendationServiceProtocol {
    private let network = Network()
    private let apiKey = "2a688e11aac3f4d3278cc7ed05a281ec"
    private let languageCode = Locale.current.languageCode
    
    func fetchRecommendations(id: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "\(network.setBaseUrl())/movie/\(id)/recommendations?api_key=\(apiKey)")!)
        network.performRequest(request: urlRequest, completion: completion)
    }
}
