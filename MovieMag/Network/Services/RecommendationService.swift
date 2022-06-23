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
    private let serviceParameterManager = ServiceParameterManager()
    
    func fetchRecommendations(id: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        if let newApiKey = serviceParameterManager.getApiKey() {
            let urlRequest = URLRequest(url: URL(string: "\(serviceParameterManager.setBaseUrl())/movie/\(id)/recommendations?api_key=\(newApiKey)")!)
            network.performRequest(request: urlRequest, completion: completion)
        }
    }
}
