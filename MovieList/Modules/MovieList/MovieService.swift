//
//  MovieAPI.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 12.04.23.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func fetchMovies(for query: String, page: Int) -> AnyPublisher<MovieResults, NSError>
}

final class MovieService: MovieServiceProtocol {
    
    //MARK: - Public functions
    func fetchMovies(for query: String, page: Int) -> AnyPublisher<MovieResults, NSError> {
        
        var request: URLRequest?
        
        if query.isEmpty {
            request = Endpoint.fetchAllMovies(page: "\(page)").buildRequest()
        } else {
            let formatedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            request = Endpoint.queryMovies(page: "\(page)", query: formatedQuery).buildRequest()
        }
        
        guard let request = request else {
            return Empty().eraseToAnyPublisher()
        }
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
