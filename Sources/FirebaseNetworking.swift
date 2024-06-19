//
//  FirebaseNetworking.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation
import FirebaseFirestore

public struct FirebaseNetworking {
    private let db = Firestore.firestore()

    public init() {}

    public func get(path: String) async throws -> Data {
        let snapshot = try await db.collection(path).getDocuments()
        let dictArray = snapshot.documents.map {
            var dict = $0.data()
            dict["id"] = $0.documentID
            return dict
        }
        return try JSONSerialization.data(withJSONObject: dictArray, options: [])
    }

    public func getDocument(path: String, id: String) async throws -> Data {
        let snapshot = try await db.collection(path).document(id).getDocument()
        var dict = snapshot.data() ?? [:]
        dict["id"] = snapshot.documentID
        return try JSONSerialization.data(withJSONObject: dict, options: [])
    }

    public func get(path: String, queryField: String, value: Any) async throws -> Data {
        let snapshot = try await db.collection(path).whereField(queryField, isGreaterThanOrEqualTo: value).getDocuments()
        let dictArray = snapshot.documents.map {
            var dict = $0.data()
            dict["id"] = $0.documentID
            return dict
        }
        return try JSONSerialization.data(withJSONObject: dictArray, options: [])
    }
}
