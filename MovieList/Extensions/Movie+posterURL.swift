//
//  Movie+PosterURL.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 10.04.23.
//

import Foundation

extension Movie {
    var posterURL: URL? {
        posterPath.flatMap { URL(string: "https://image.tmdb.org/t/p/original\($0)") }
    }
}
