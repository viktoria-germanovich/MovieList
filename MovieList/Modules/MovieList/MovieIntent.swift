//
//  MoviesIntent.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 26.03.23.
//

import UIKit
import Combine
import CombineFeedback
import CombineFeedbackUI

protocol MovieIntentProtocol {
    func bind(to view: MovieListDisplay)
}

final class MovieIntent {
    
    //MARK: - Properties
    private var view: MovieListDisplay?
    private let service: MovieServiceProtocol = MovieService()
    
    //MARK: - Public functions
    func bind(to view: MovieListDisplay) {
        self.view = view
    }
    
    //MARK: - Public functions
    func whenLoadingMovies() -> Feedback<MovieState, MovieEvent> {
        Feedback { state -> AnyPublisher<MovieEvent, Never> in
            if state.status == .loading {
                return self.service
                    .fetchMovies(for: state.query)
                    .map(MovieEvent.didLoad)
                    .replaceError(with: MovieEvent.didFail)
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            } else {
                return Empty().eraseToAnyPublisher()
            }
        }
    }
    
    func reducer(state: inout MovieState, event: MovieEvent) {
        switch event {
        case .didLoad(let movies):
            if movies.results.isEmpty {
                state.status = .noData
                state.movies = []
            } else {
                state.movies = movies.results
                state.status = .loaded
            }
        case .didFail:
            state.status = .noData
            state.movies = []
        case .filter(let query):
            state.query = query
            state.movies = []
            state.status = .loading
        case .select(let movie):
            state.selectedMovie = movie
            state.status = .selected
        }
        view?.update(with: state)
    }
}
