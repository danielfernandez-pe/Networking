//
//  HeadersMiddlewareType.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 28.10.2025.
//

public protocol HeadersMiddlewareType {
    func defaultHeaders() -> [String: String]
}

final class DefaultHeadersMiddleware: HeadersMiddlewareType {
    func defaultHeaders() -> [String : String] {
        // this should be implemented on clients
        [:]
    }
}
