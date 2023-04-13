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
    var batch: MovieResults
    var movies: [Movie]
    var query: String
    var nextPage: Int
    
    static let firstPage: Int = 1
    static let initial = MovieState(
        selectedMovie: nil,
        status: .loading,
        batch: MovieResults.empty,
        movies: [],
        query: "",
        nextPage: firstPage
    )
}
