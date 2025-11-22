//
//  HeadersMiddlewareType.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 28.10.2025.
//

public protocol HeadersMiddlewareType: Sendable {
    func defaultHeaders() async -> [String: String]
}

final class DefaultHeadersMiddleware: HeadersMiddlewareType {
    func defaultHeaders() async -> [String : String] {
        // this should be implemented on clients
        [:]
    }
}
