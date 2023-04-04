//
//  MovieViewControllerSpy.swift
//  MovieListTests
//
//  Created by Viktoryia Hermanovich on 4.04.23.
//

import XCTest
@testable import MovieList

final class MovieViewControllerSpy: MovieListDisplay  {
    func update(with state: MovieState) {}
}
