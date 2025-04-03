//
//  APIError.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 28.12.2024.
//

import Foundation

public enum APIError: Error, CustomStringConvertible, LocalizedError {
    case decodingError
    case encodingError
    case invalidResponse
    case notAuthorized
    case notFound
    case networkError(String)
    case backendError(LocalizedError)
    
    // This description comes from CustomStringConvertible which help when you print or log the errors
    public var description: String {
        switch self {
        case .decodingError:
            return "We couldn't parse the data to the correct format"
        case .encodingError:
            return "The body to send cannot be encoded properly"
        case .invalidResponse:
            return "Backend sent invalid response"
        case .notAuthorized:
            return "Not authorized"
        case .notFound:
            return "Server returned 404. Resource not found"
        case .networkError(let desc):
            return desc
        case .backendError(let error):
            return error.errorDescription ?? "Unkown backend error"
        }
    }
    
    // This errorDescription comes from LocalizedError which help when you put error.localizedDescription in the viewModels
    public var errorDescription: String? {
        description
    }
}
