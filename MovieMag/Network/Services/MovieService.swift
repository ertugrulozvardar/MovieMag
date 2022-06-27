//
//  MovieService.swift
//  MovieMag
//
//  Created by obss on 31.05.2022.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void)
    func fetchAllMovies(page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
    func searchAllMovies(searchQuery: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void)
}

struct MovieService: MovieServiceProtocol {
    private let network = Network()
    
    func fetchMovie(id: Int, completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        network.performRequest(request: MovieRequest.fetchMovie(id: id), completion: completion)
    }
    
    func fetchAllMovies(page: Int, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        network.performRequest(request: MovieRequest.fetchAllMovies(page: page), completion: completion)
    }
    
    func searchAllMovies(searchQuery: String, completion: @escaping (Result<AllMovieResponse, NetworkError>) -> Void) {
        network.performRequest(request: MovieRequest.searchAllMovies(searchQuery: searchQuery), completion: completion)
    }
}
