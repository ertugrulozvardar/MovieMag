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
    private let apiKey = "2a688e11aac3f4d3278cc7ed05a281ec"
    private let languageCode = Locale.current.languageCode
    
    func fetchMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "\(network.setBaseUrl())/movie/\(id)?api_key=\(apiKey)&language=\(languageCode ?? "en")")!)
            network.performRequest(request: urlRequest, completion: completion)
    }
    
    func fetchAllMovies(atPage page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
            let urlRequest = URLRequest(url: URL(string: "\(network.setBaseUrl())/movie/popular?api_key=\(apiKey)&page=\(page)")!)
            network.performRequest(request: urlRequest, completion: completion)
    }
    
    func searchAllMovies(with searchQuery: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        // Comment
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        let url = "\(network.setBaseUrl())/search/movie?api_key=\(apiKey)&query=\(searchQuery)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlRequest = URLRequest(url: URL(string: encodedUrl!)!)
        network.performRequest(request: urlRequest, completion: completion)
    }
}
