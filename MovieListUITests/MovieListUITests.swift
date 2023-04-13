//
//  MovieListUITests.swift
//  MovieListUITests
//
//  Created by Viktoryia Hermanovich on 4.04.23.
//

import iOSSnapshotTestCase
import MovieList

class MovieListUITests: FBSnapshotTestCase {
    
    private (set) var viewController: MovieViewController!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        //recordMode = true
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = MovieViewController()
    }
    
    //MARK: - Tests
    func testNoDataState() {
        
        // Given
        let state = MovieState.initial
        
        // When
        viewController.update(with: state)
        
        // Then
        FBSnapshotVerifyViewController(viewController)
    }
    
    func testLoadedState() {
        
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
                posterPath: "Test poster 32",
                voteAverage: 2)
        ]
        let state = MovieState(
            status: MovieState.Status.loaded,
            batch: MovieResults(page: MovieState.firstPage, results: movies, totalPages: 0),
            movies: movies,
            query: "",
            nextPage:MovieState.firstPage
        )
        
        // When
        viewController.update(with: state)
        
        // Then
        FBSnapshotVerifyViewController(viewController)
    }
}
