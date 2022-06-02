//
//  MovieService.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchAllMovies(atPage page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
    func searchAllMovies(searchBy searchText: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
}

struct MovieService: MovieServiceProtocol {
    
    private let network = Network()
    private let apiKey = "2a688e11aac3f4d3278cc7ed05a281ec"
    
    func fetchAllMovies(atPage page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
            let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=\(page)")!)
            network.performRequest(request: urlRequest, completion: completion)
        }
    
    func searchAllMovies(searchBy searchText: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&query=\(searchText)")!)
        network.performRequest(request: urlRequest, completion: completion)
    }
}
