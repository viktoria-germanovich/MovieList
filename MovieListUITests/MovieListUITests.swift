//
//  MovieListUITests.swift
//  MovieListUITests
//
//  Created by Viktoryia Hermanovich on 4.04.23.
//

import XCTest
import SnapshotTesting
@testable import MovieList

class MovieListUITests: XCTestCase {
    
    //MARK: - Properties
    private (set) var viewController = MovieViewController()
    
    func testMovieViewController() {
        let frame = CGRect(x: 0, y: 0, width: 375, height: 667) // что-то он не сработал😅
        viewController.view.frame = frame
        testNoDataState()
        testLoadingState()
        testLoadedState()
        testSelectedMovieState()
    }
    
    //MARK: - Tests
    private func testNoDataState() {
        
        // Given
        let state = MovieState(status: MovieState.Status.noData, movies: [], query: "")
        
        // When
        viewController.update(with: state)
        
        // Then
        assertSnapshot(matching: viewController, as: .image)
    }
    
    private func testLoadingState() {
        
        // Given
        let state = MovieState(status: MovieState.Status.loading, movies: [], query: "")
        
        // When
        viewController.update(with: state)
        
        // Then
        assertSnapshot(matching: viewController, as: .image)
    }
    
    private func testLoadedState() {
        
        // Given
        let movies = [
            Movie(
                id: 1,
                overview: "Test overview 1",
                title: "Test movie 1",
                posterPath: "Test poster 1",
                voteAverage: 1),
            Movie(
                id: 2,
                overview: "Test overview 2",
                title: "Test movie 2",
                posterPath: "Tset poster 2",
                voteAverage: 2)
        ]
        let state = MovieState(status: MovieState.Status.loaded, movies: movies, query: "")
        
        // When
        viewController.update(with: state)
        
        // Then
        assertSnapshot(matching: viewController, as: .image)
    }
    
    private func testSelectedMovieState() {
        
        // Given
        let selectedMovie = Movie(
            id: 2,
            overview: "Test overview 2",
            title: "Test movie 2",
            posterPath: "Tset poster 2",
            voteAverage: 2)
        let movies = [ Movie(
            id: 1,
            overview: "Test overview 1",
            title: "Test movie 1",
            posterPath: "Test poster 1",
            voteAverage: 1), selectedMovie
        ]
        let state = MovieState(selectedMovie: selectedMovie, status: MovieState.Status.selected, movies: movies, query: "")
        
        // When
        viewController.update(with: state)
        
        // Then
        assertSnapshot(matching: viewController, as: .image)
    }
}
