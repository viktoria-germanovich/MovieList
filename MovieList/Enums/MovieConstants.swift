//
//  GlobalConstants.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 13.04.23.
//

import Foundation

enum MovieConstants {
    
    static let appTitle = "Movies"
    static let apiKeyName = "API_KEY"
    
    enum FatalError {
        static let initError = "init(coder:) has not been implemented"
        static let missingApiKeyError = "API key not found in plist file"
    }
    
}
