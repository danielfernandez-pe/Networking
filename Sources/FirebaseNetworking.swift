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
        let dictArray = snapshot.documents.map { $0.data() }
        return try JSONSerialization.data(withJSONObject: dictArray, options: [])
    }
}
