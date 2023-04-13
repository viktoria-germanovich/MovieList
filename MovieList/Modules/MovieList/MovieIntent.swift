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
    func whenLoadingMovies() -> Feedback<MovieState, MovieEvent>
    func reducer(state: inout MovieState, event: MovieEvent)
}

final class MovieIntent {
    
    //MARK: - Properties
    private var view: MovieListDisplay?
    private let service: MovieServiceProtocol = MovieService()
    
    //MARK: - Public functions
    func bind(to view: MovieListDisplay) {
        self.view = view
    }
    
    func whenLoadingMovies() -> Feedback<MovieState, MovieEvent> {
        Feedback { state -> AnyPublisher<MovieEvent, Never> in
            if state.status == .loading {
                return self.service
                    .fetchMovies(for: state.query, page: state.nextPage)
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
                state.movies += movies.results
                state.status = .loaded
                state.batch = movies
                state.nextPage = movies.page + 1
            }
        case .didFail:
            state.status = .noData
            state.movies = []
            state.nextPage = MovieState.firstPage
        case .filter(let query):
            state.query = query
            state.movies = []
            state.status = .loading
            state.nextPage = MovieState.firstPage
        case .select(let movie):
            state.selectedMovie = movie
            state.status = .selected
        case .fetchNext:
            state.status = .loading
        }
        view?.update(with: state)
    }
}
