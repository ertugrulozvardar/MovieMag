//
//  CastService.swift
//  MovieMag
//
//  Created by pc on 22.06.2022.
//

import Foundation

protocol CastServiceProtocol {
    func fetchSingleCast(castId: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void)
    func fetchCasts(id: Int, completion: @escaping (Result<Credits, NetworkError>) -> Void)
}

struct CastService: CastServiceProtocol {
    private let network = Network()
    private let apiKey = "2a688e11aac3f4d3278cc7ed05a281ec"
    private let languageCode = Locale.current.languageCode
    
    func fetchSingleCast(castId: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "\(network.setBaseUrl())/person/\(castId)?api_key=\(apiKey)&language=\(languageCode ?? "en")")!)
        network.performRequest(request: urlRequest, completion: completion)
    }
    
    func fetchCasts(id: Int, completion: @escaping (Result<Credits, NetworkError>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "\(network.setBaseUrl())/movie/\(id)/credits?api_key=\(apiKey)")!)
        network.performRequest(request: urlRequest, completion: completion)
    }
}

