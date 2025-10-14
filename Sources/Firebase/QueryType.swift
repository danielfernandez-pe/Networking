//
//  QueryType.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 14.10.2025.
//

public enum QueryType: Sendable {
    case isEqualTo(field: String, value: String)
    case isNotEqualTo(field: String, value: String)
    case isGreaterThan(field: String, value: String)
    case isLessThan(field: String, value: String)
}
