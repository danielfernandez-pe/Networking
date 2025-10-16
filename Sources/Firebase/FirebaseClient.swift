//
//  FirebaseClient.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 12.10.2025.
//

import FirebaseFirestore
import FirebaseAuth

public actor FirebaseClient {
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private let decoder = Firestore.Decoder()

    public init() {
        decoder.dateDecodingStrategy = .iso8601
    }

    ///
    /// Returns: User Id
    ///
    public func signUp(withEmail email: String, password: String) async throws -> String {
        let authResult = try await auth.createUser(withEmail: email, password: password)
        return authResult.user.uid
    }
    
    ///
    /// Returns: User Id
    ///
    public func signIn(withEmail email: String, password: String) async throws -> String {
        let authResult = try await auth.signIn(withEmail: email, password: password)
        return authResult.user.uid
    }
    
    public func signOut() throws {
        try auth.signOut()
    }
    
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
        path: String,
        queries: [QueryType] = []
    ) async throws(APIError) -> [T] {
        do {
            var snapshot: Query = db.collection(path)
            
            for query in queries {
                switch query {
                case .isEqualTo(let field, let value):
                    snapshot = snapshot.whereField(field, isEqualTo: value)
                case .isNotEqualTo(let field, let value):
                    snapshot = snapshot.whereField(field, isNotEqualTo: value)
                case .isGreaterThan(let field, let value):
                    snapshot = snapshot.whereField(field, isGreaterThan: value)
                case .isLessThan(let field, let value):
                    snapshot = snapshot.whereField(field, isLessThan: value)
                }
            }
            
            let collection = try await snapshot.getDocuments()
            let data = try collection.documents.map { try $0.data(as: T.self, decoder: decoder) }
            return data
        } catch {
            throw APIError.decodingError
        }
    }
    
    public func setData<T: Encodable & Identifiable>(
        path: String,
        model: T
    ) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            do {
                try db.collection(path).document("\(model.id)").setData(from: model) { error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume()
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
