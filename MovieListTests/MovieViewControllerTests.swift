//
//  MovieViewControllerTests.swift
//  MovieListTests
//
//  Created by Viktoryia Hermanovich on 4.04.23.
//

import XCTest
@testable import MovieList

class MovieViewControllerTests: XCTestCase {
    
    //MARK: - Properties
    private (set) var sut: MovieViewController!
    
    // MARK: - Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MovieViewController()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Tests
    func testUpdateWithLoadingState() {
        
        //Given
        let state = MovieState(status: .loading, movies: [], query: "")
        
        //Then
        XCTAssertNoThrow(sut.update(with: state), "Should check update not fails with loading state")
    }
    
    func testUpdateWithNoDataState() {
        
        //Given
        let state = MovieState(status: .noData, movies: [], query: "")
        
        //Then
        XCTAssertNoThrow(sut.update(with: state), "Should check update not fails with noData state")
    }
    
    func testUpdateWithSelectedState() {
        
        //Given
        let state = MovieState(status: .selected, movies: [], query: "")
        
        //Then
        XCTAssertNoThrow(sut.update(with: state), "Should check update not fails with selected state")
    }
    
    func testUpdateWithLoadedState() {
        
        //Given
        let state = MovieState(status: .loaded, movies: [], query: "")
        
        //Then
        XCTAssertNoThrow(sut.update(with: state), "Should check update not fails with loaded state")
    }
}
