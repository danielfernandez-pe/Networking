//
//  AuthMiddlewareType.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 30.07.2025.
//

public protocol AuthMiddlewareType {
    /// This method is called when networking gets 401
    func onNonAuthenticatedRequest()
}

final class DefaultAuthMiddleware: AuthMiddlewareType {
    func onNonAuthenticatedRequest() {
        // this should be implemented on clients
    }
}
