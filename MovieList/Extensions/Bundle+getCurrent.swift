//
//  Bundle+getCurrent.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 13.04.23.
//

import Foundation

extension Bundle {
    static var current: Bundle {
        class __ { }
        return Bundle(for: __.self)
    }
}
