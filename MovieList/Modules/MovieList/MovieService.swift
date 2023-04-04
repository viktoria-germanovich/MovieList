//
//  MoviesAPI.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 26.03.23.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func fetchMovies(for query: String) -> AnyPublisher<MovieResults, NSError>
}

final class MovieService: MovieServiceProtocol {
    
    //MARK: - Constants
    private struct Constants {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let searchPath = "/3/search/movie"
        static let discoverPath = "/3/discover/movie"
        static let apiKey = "d4f0bdb3e246e2cb3555211e765c89e3"
        static let getMethod = "GET"
        static let apiKeyName = "api_key"
        static let queryName = "query"
        static let pageName = "page"
        static let firstPage = "1"
    }
    
    //MARK: - Public functions
    func fetchMovies(for query: String) -> AnyPublisher<MovieResults, NSError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = query.isEmpty ? Constants.discoverPath : Constants.searchPath
        
        let formatedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? nil
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.apiKeyName, value: Constants.apiKey),
            URLQueryItem(name: Constants.queryName, value: formatedQuery),
            URLQueryItem(name: Constants.pageName, value: Constants.firstPage)]
        guard let url = urlComponents.url  else {
            return Empty().eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MovieResults.self, decoder: JSONDecoder())
            .mapError { (error) -> NSError in
                error as NSError
            }
            .eraseToAnyPublisher()
    }
}
