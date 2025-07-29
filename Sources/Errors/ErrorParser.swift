//
//  ErrorParser.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 01.04.2025.
//

import Foundation

public protocol ErrorParserType {
    func parse(data: Data) -> LocalizedError?
}

final class DefaultErrorParser: ErrorParserType {
    func parse(data: Data) -> LocalizedError? {
        // this method should be implemented on client apps
        nil
    }
}
