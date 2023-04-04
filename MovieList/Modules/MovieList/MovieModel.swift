//
//  MoviesModel.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 26.03.23.
//

import Foundation

struct MovieResults: Codable, Equatable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    static func empty() -> MovieResults {
        return MovieResults(page: 0, totalResults: 0, totalPages: 0, results: [])
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable, Hashable, Identifiable {
    let id: Int
    let overview: String
    let title: String
    let posterPath: String?
    let voteAverage: Double
    
    var posterURL: URL? {
        return posterPath.map {"https://image.tmdb.org/t/p/w154\($0)"}.flatMap(URL.init(string:))
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

enum MovieEvent: Equatable {
    case didLoad(MovieResults)
    case didFail
    case filter(with: String)
    case select(_ movie: Movie)
}
