//
//  MovieRequest.swift
//  MovieMag
//
//  Created by pc on 27.06.2022.
//

import Foundation

enum MovieRequest {
    
    case fetchMovie(id: Int)
    case fetchAllMovies(page: Int)
    case searchAllMovies(searchQuery: String)
}

extension MovieRequest: Requestable {
    
    var URLpath: String {
        var urlComponents = URLComponents(string: baseURL)!
        switch self {
        case .fetchMovie(let id):
            urlComponents.path = "/\(baseNumberParameter)/movie/\(id)"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "language", value: languageCode)
            ]
            return urlComponents.string!
        case .fetchAllMovies(let page):
            urlComponents.path = "/\(baseNumberParameter)/movie/popular"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "page", value: String(page))
            ]
            return urlComponents.string!
        case .searchAllMovies(let searchQuery):
            urlComponents.path = "/\(baseNumberParameter)/search/movie"
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "query", value: searchQuery)
            ]
            let url = urlComponents.string!
            let percentedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return percentedURL
        }
    }
    
    var URLparameters: Data? {
        switch self {
        case .fetchMovie,
             .fetchAllMovies,
             .searchAllMovies:
            return nil
        }
    }
    
    
}
