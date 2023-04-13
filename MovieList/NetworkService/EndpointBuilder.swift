//
//  Endpoint.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 13.04.23.
//

import Foundation

protocol EndpointBuilder {
    func buildRequest() -> URLRequest?
}

enum Endpoint: EndpointBuilder {
    
    // MARK: - Constants
    private enum Constants {
        enum Base {
            static let scheme: String = "https"
            static let host: String = "api.themoviedb.org"
        }
        enum Path {
            static let searchPath: String = "/3/search/movie"
            static let discoverPath = "/3/discover/movie"
        }
        enum Parameter {
            static let apiKey = "api_key"
            static let query = "query"
            static let page = "page"
        }
    }
    
    //MARK: - Endpoints
    case fetchAllMovies(page: String)
    case queryMovies(page: String, query: String)
    
    //MARK: - Build request
    func buildRequest() -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.host = Constants.Base.host
        urlComponents.scheme = Constants.Base.scheme
        let apiKey = getApiKey()
        switch self {
        case .fetchAllMovies(let page):
            urlComponents.path = Constants.Path.discoverPath
            urlComponents.queryItems =  [
                URLQueryItem(name: Constants.Parameter.page, value: page),
                URLQueryItem(name: Constants.Parameter.apiKey, value: apiKey)
            ]
        case .queryMovies(let page, let query):
            urlComponents.path = Constants.Path.searchPath
            urlComponents.queryItems = [
                URLQueryItem(name: Constants.Parameter.query, value: query),
                URLQueryItem(name: Constants.Parameter.page, value: page),
                URLQueryItem(name: Constants.Parameter.apiKey, value: apiKey)
            ]
        }
        guard let url = urlComponents.url  else {
            return nil
        }
        return URLRequest(url: url)
    }
    
}

//MARK: - Api key getter
extension Endpoint {
    func getApiKey() -> String {
        guard let api_key = Bundle.current.object(forInfoDictionaryKey: MovieConstants.apiKeyName) as? String else {
            fatalError(MovieConstants.FatalError.missingApiKeyError)
        }
       return api_key
    }
}
