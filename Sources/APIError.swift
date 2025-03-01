//
//  APIError.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 28.12.2024.
//

public enum APIError: Error, CustomStringConvertible {
    case decodingError
    case encodingError
    case invalidResponse
    case networkError(String)
    
    public var description: String {
        switch self {
        case .decodingError:
            return "We couldn't parse the data to the correct format"
        case .encodingError:
            return "The body to send cannot be encoded properly"
        case .invalidResponse:
            return "Backend sent invalid response"
        case .networkError(let desc):
            return desc
        }
    }
}
