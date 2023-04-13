//
//  MoviesModel.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 26.03.23.
//

import Foundation

struct MovieResults: Decodable, Equatable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    static let empty = MovieResults(page: 0, results: [], totalPages: 0)
}

struct Movie: Decodable, Hashable {
    let id: Int
    let overview: String
    let title: String
    let posterPath: String?
    let voteAverage: Double
}

