//
//  Requestable.swift
//  MovieMag
//
//  Created by pc on 27.06.2022.
//

import Foundation

protocol Requestable {
    
    var baseURL: String { get }
    var URLpath: String { get }
    var apiKey: String { get }
    var languageCode: String { get }
    func convertToURLRequest() -> URLRequest
}

extension Requestable {
    
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var apiKey: String {
        return "2a688e11aac3f4d3278cc7ed05a281ec"
    }
    
    var languageCode: String {
        return Locale.current.languageCode ?? "en"
    }
    
    func convertToURLRequest() -> URLRequest {
        let request = URLRequest(url: URL(string: URLpath)!)
        return request
    }
}
