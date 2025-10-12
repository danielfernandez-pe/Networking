//
//  APIError.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 12.10.2025.
//

import Foundation

public enum APIError: Error, CustomStringConvertible, LocalizedError {
    case decodingError
    
    // This description comes from CustomStringConvertible which help when you print or log the errors
    public var description: String {
        switch self {
        case .decodingError:
            return "We couldn't parse the data to the correct format"
        }
    }
    
    // This errorDescription comes from LocalizedError which help when you put error.localizedDescription in the viewModels
    public var errorDescription: String? {
        description
    }
}
