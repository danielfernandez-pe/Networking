//
//  FirebaseClient.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 12.10.2025.
//

import FirebaseFirestore

public actor FirebaseClient {
    private let db = Firestore.firestore()

    public init() {}

    public func getItem<T: Decodable>(
        path: String
    ) async throws(APIError) -> T {
        do {
            let snapshot = try await db.document(path).getDocument()
            return try snapshot.data(as: T.self)
        } catch {
            throw APIError.decodingError
        }
    }
    
    public func getItems<T: Decodable>(
        path: String
    ) async throws(APIError) -> [T] {
        do {
            let snapshot = try await db.collection(path).getDocuments()
            let data = try snapshot.documents.map {
                let data = $0.data()
                return try $0.data(as: T.self)
            }
            return data
        } catch {
            throw APIError.decodingError
        }
    }
}
