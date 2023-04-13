//
//  Movie+CodingKeys.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 10.04.23.
//

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

extension MovieResults {
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}
