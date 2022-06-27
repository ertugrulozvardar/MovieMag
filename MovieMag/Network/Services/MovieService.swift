//
//  MovieService.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void)
    func fetchAllMovies(atPage page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
    func searchAllMovies(with searchQuery: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
}

struct MovieService: MovieServiceProtocol {
    private let network = Network()
    private let serviceParameterManager = ServiceParameterManager()
    private let languageCode = Locale.current.languageCode
    
    func fetchMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        if let newApiKey = serviceParameterManager.getApiKey() {
            let urlRequest = URLRequest(url: URL(string: "\(serviceParameterManager.setBaseUrl())/movie/\(id)?api_key=\(newApiKey)&language=\(languageCode ?? "en")")!)
                network.performRequest(request: urlRequest, completion: completion)
        }
    }
    
    func fetchAllMovies(atPage page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        if let newApiKey = serviceParameterManager.getApiKey() {
            let urlRequest = URLRequest(url: URL(string: "\(serviceParameterManager.setBaseUrl())/movie/popular?api_key=\(newApiKey)&page=\(page)")!)
            network.performRequest(request: urlRequest, completion: completion)
        }
    }
    
    func searchAllMovies(with searchQuery: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        // Comment
        if let newApiKey = serviceParameterManager.getApiKey() {
            let url = "\(serviceParameterManager.setBaseUrl())/search/movie?api_key=\(newApiKey)&query=\(searchQuery)"
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let urlRequest = URLRequest(url: URL(string: encodedUrl!)!)
            network.performRequest(request: urlRequest, completion: completion)
        }
    }
}
