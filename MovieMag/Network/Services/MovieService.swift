//
//  MovieService.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchAllMovies(atPage page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
    func searchAllMovies(with searchQuery: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
    func fetchMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void)
    func fetchCasts(id: Int, completion: @escaping (Result<Credits, NetworkError>) -> Void)
    func fetchRecommendations(id: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
    func fetchSingleCast(castId: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void)
}

struct MovieService: MovieServiceProtocol {
    
    private let network = Network()
    private let apiKey = "2a688e11aac3f4d3278cc7ed05a281ec"
    
    func fetchAllMovies(atPage page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
            let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=\(page)")!)
            network.performRequest(request: urlRequest, completion: completion)
    }
    
    func searchAllMovies(with searchQuery: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        guard !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(searchQuery)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlRequest = URLRequest(url: URL(string: encodedUrl!)!)
        network.performRequest(request: urlRequest, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
            let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)")!)
            network.performRequest(request: urlRequest, completion: completion)
    }
    
    func fetchCasts(id: Int, completion: @escaping (Result<Credits, NetworkError>) -> Void) {
            let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(apiKey)")!)
            network.performRequest(request: urlRequest, completion: completion)
    }
    
    func fetchRecommendations(id: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
            let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(apiKey)")!)
            network.performRequest(request: urlRequest, completion: completion)
    }
    
    func fetchSingleCast(castId: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void) {
            let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/person/\(castId)?api_key=\(apiKey)")!)
            network.performRequest(request: urlRequest, completion: completion)
    }
}
