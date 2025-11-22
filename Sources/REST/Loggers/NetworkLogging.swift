//
//  NetworkLogging.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 29.03.2025.
//

public protocol NetworkLogging: Sendable {
    func log(_ message: String)
}
