//
//  MovieEvent.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 10.04.23.
//

enum MovieEvent: Equatable {
    case didLoad(MovieResults)
    case didFail
    case filter(with: String)
    case select(Movie)
    case fetchNext
}
