//
//  MovieState.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 27.03.23.
//

struct MovieState {
    enum Status {
        case loaded
        case loading
        case noData
        case selected
    }
    var selectedMovie: Movie?
    var status: Status
    var movies: [Movie]
    var query: String
}
