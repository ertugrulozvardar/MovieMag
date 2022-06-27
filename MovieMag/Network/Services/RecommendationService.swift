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
    
    func fetchRecommendations(id: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        network.performRequest(request: RecommendationRequest.fetchRecommendations(id: id), completion: completion)
    }
}
