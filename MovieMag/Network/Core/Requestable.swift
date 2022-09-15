//
//  Requestable.swift
//  MovieMag
//
//  Created by pc on 27.06.2022.
//

import Foundation

protocol Requestable {
    
    var baseURL: String { get }
    var baseNumberParameter: Int { get }
    var URLpath: String { get }
    var apiKey: String { get }
    var languageCode: String { get }
    func convertToURLRequest() -> URLRequest
}

extension Requestable {
    
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var baseNumberParameter: Int {
        return 3
    }
    
    var apiKey: String {
        return "YOUR_API_KEY_HERE"
    }
    
    var languageCode: String {
        return Locale.current.languageCode ?? "en"
    }
    
    func convertToURLRequest() -> URLRequest {
        let request = URLRequest(url: URL(string: URLpath)!)
        return request
    }
}
