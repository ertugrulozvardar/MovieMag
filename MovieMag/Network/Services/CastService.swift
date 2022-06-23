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
    private let serviceParameterManager = ServiceParameterManager()
    private let languageCode = Locale.current.languageCode
    
    func fetchSingleCast(castId: Int, completion: @escaping (Result<CastDetail, NetworkError>) -> Void) {
        if let newApiKey = serviceParameterManager.getApiKey() {
            let urlRequest = URLRequest(url: URL(string: "\(serviceParameterManager.setBaseUrl())/person/\(castId)?api_key=\(newApiKey)&language=\(languageCode ?? "en")")!)
            network.performRequest(request: urlRequest, completion: completion)
        }
        
    }
    
    func fetchCasts(id: Int, completion: @escaping (Result<Credits, NetworkError>) -> Void) {
        if let newApiKey = serviceParameterManager.getApiKey() {
            let urlRequest = URLRequest(url: URL(string: "\(serviceParameterManager.setBaseUrl())/movie/\(id)/credits?api_key=\(newApiKey)")!)
            network.performRequest(request: urlRequest, completion: completion)
        }
    }
}

