//
//  APIClient.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 28.12.2024.
//

import Foundation
import Lumberjack

public actor APIClient {
    private let session: URLSession
    private let logger: LumberjackCoordinator
    
    public init(logger: LumberjackCoordinator) {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 30
        
        session = URLSession(configuration: configuration)
        self.logger = logger
    }
    
    public func get<T: Decodable>(
        _ url: URL,
        headers: [String: String]? = nil
    ) async throws -> T {
        logRequest(
            url: url,
            method: "GET",
            headers: headers,
            body: nil
        )

        return try await request(url: url, method: .GET, headers: headers)
    }
    
    public func post<T: Decodable, U: Encodable>(
        _ url: URL,
        body: U,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(url: url, method: .POST, body: body, headers: headers)
    }
    
    public func patch<T: Decodable, U: Encodable>(
        _ url: URL,
        body: U,
        headers: [String: String]? = nil
    ) async throws -> T {
        try await request(url: url, method: .PATCH, body: body, headers: headers)
    }
    
    public func delete(
        _ url: URL,
        headers: [String: String]? = nil
    ) async throws {
        try await request(url: url, method: .DELETE, headers: headers)
    }
    
    private func request(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?
    ) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        let (_, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200..<300 ~= httpResponse.statusCode) {
            throw APIError.invalidResponse
        }
    }
    
    private func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return try await makeRequest(request, type: T.self)
    }
    
    private func request<T: Decodable, U: Encodable>(
        url: URL,
        method: HTTPMethod,
        body: U,
        headers: [String: String]?
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return try await makeRequest(request, type: T.self)
    }
    
    private func makeRequest<T: Decodable>(_ request: URLRequest, type: T.Type) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        do {
            return try CustomDecoder.main.decode(type, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
    
    private func logRequest(
        url: URL,
        method: String,
        headers: [String: String]?,
        body: Data?
    ) {
        let formattedHeaders = headers?.map { "\"\($0.key)\": \"\($0.value)\"" }.joined(separator: ", ") ?? "None"
        let bodyString = body.flatMap { String(data: $0, encoding: .utf8) } ?? "None"

        let logMessage = """
        [HTTP Request]
        Method: \(method)
        URL: \(url.absoluteString)
        Headers: {
            \(formattedHeaders)
        }
        Body: \(bodyString)
        """
        logger.info(logMessage)
    }
}
