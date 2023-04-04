//
//  MovieIntentTests.swift
//  MovieListTests
//
//  Created by Viktoryia Hermanovich on 4.04.23.
//

import XCTest
@testable import MovieList

class MovieIntentTests: XCTestCase {
    
    //MARK: - Properties
    private (set) var sut: MovieIntent!
    private (set) var state: MovieState!
    private (set) var view: MovieViewControllerSpy!
    
    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MovieIntent()
        view = MovieViewControllerSpy()
        state = MovieState(status: .loading, movies: [], query: "")
        sut.bind(to: view)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        view = nil
        state = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Tests
    func testWhenLoadingMoviesFeedback() {
        
        // Given
        let didLoadEvent: MovieEvent = .didLoad(MovieResults.empty())
        
        // Then
        let feedback = sut.whenLoadingMovies()
            .mapEvent { event in
                XCTAssertEqual(event, didLoadEvent, "Should check didLoad event")
            }
        XCTAssertNotNil(feedback, "Should check feedback")
    }
    
    func testReducerDidLoadEvent() {
        
        // Given
        let results = (MovieResults(
            page: 1,
            totalResults: 1,
            totalPages: 1,
            results: [Movie(
                id: 1,
                overview: "Test overview",
                title: "Test movie",
                posterPath: "Test poster",
                voteAverage: 1.0)]))
        let event: MovieEvent = .didLoad(results)
        
        // When
        sut.reducer(state: &state, event: event)
        
        // Then
        XCTAssertEqual(state.status, .loaded, "Should check state changed for loaded")
        XCTAssertFalse(state.movies.isEmpty, "Should check that movies not empty")
    }
    
    func testReducerDidFailEvent() {
        
        // Given
        let event: MovieEvent = .didFail
        
        // When
        sut.reducer(state: &state, event: event)
        
        // Then
        XCTAssertEqual(state.status, .noData, "Should check state changed for noData")
        XCTAssertTrue(state.movies.isEmpty, "Should check that movies empty")
    }
    
    func testReducerFilterEvent() {
        
        // Given
        let query = "test"
        let event: MovieEvent = .filter(with: query)
        
        // When
        sut.reducer(state: &state, event: event)
        
        // Then
        XCTAssertEqual(state.status, .loading, "Should check state changed for loaded")
        XCTAssertTrue(state.movies.isEmpty, "Should check that movies empty")
        XCTAssertEqual(state.query, query, "Should check that query was set")
    }
    
    func testReducerSelectEvent() {
        
        // Given
        let movie = Movie(
            id: 1,
            overview: "Test overview",
            title: "Test movie",
            posterPath: "Test poster",
            voteAverage: 1.0)
        let event: MovieEvent = .select(movie)
        
        // When
        sut.reducer(state: &state, event: event)
        
        // Then
        XCTAssertEqual(state.status, .selected, "Should check that state changes for selected")
        XCTAssertEqual(state.selectedMovie, movie, "Should check that selected movies was set")
    }
}


