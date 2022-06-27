//
//  CastRequest.swift
//  MovieMag
//
//  Created by pc on 27.06.2022.
//

import Foundation

enum CastRequest {
    
    case fetchSingleCast(castId: Int)
    case fetchCasts(id: Int)
}

extension CastRequest: Requestable {
    var URLpath: String {
        var urlComponents = URLComponents(string: baseURL)!
        switch self {
        case .fetchSingleCast(let castId):
            urlComponents.path = "/\(baseNumberParameter)/person/\(castId)"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "language", value: languageCode)
            ]
            return urlComponents.string!
        case .fetchCasts(let id):
            urlComponents.path = "/\(baseNumberParameter)/movie/\(id)/credits"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
            ]
            return urlComponents.string!
        }
    }
    
    var URLparameters: Data? {
        switch self {
        case .fetchSingleCast,
             .fetchCasts:
            return nil
        }
    }
    
    
}
