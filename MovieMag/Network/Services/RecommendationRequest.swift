//
//  RecommendationRequest.swift
//  MovieMag
//
//  Created by pc on 27.06.2022.
//

import Foundation

enum RecommendationRequest {
    case fetchRecommendations(id: Int)
}

extension RecommendationRequest: Requestable {
    var URLpath: String {
        var urlComponents = URLComponents(string: baseURL)!
        switch self {
        case .fetchRecommendations(let id):
            urlComponents.path = "/\(baseNumberParameter)/movie/\(id)/recommendations"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
            ]
            return urlComponents.string!
        }
    }
    
    var URLparameters: Data? {
        switch self {
        case .fetchRecommendations:
            return nil
        }
    }
}

