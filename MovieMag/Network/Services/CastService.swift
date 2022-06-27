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
    
    func fetchSingleCast(castId: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void) {
        network.performRequest(request: CastRequest.fetchSingleCast(castId: castId), completion: completion)
    }
    
    func fetchCasts(id: Int, completion: @escaping (Result<Credits, NetworkError>) -> Void) {
        network.performRequest(request: CastRequest.fetchCasts(id: id), completion: completion)
    }
}

