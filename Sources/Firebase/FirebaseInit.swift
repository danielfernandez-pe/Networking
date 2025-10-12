//
//  FirebaseInit.swift
//  Networking
//
//  Created by Daniel Fernandez Yopla on 12.10.2025.
//

import Foundation
import Firebase

public struct FirebaseInit {
    public static func initializeFirebase(with plistPath: String) {
        guard let options = FirebaseOptions(contentsOfFile: plistPath) else {
            fatalError("We have a problem with Firebase configuration")
        }
        FirebaseApp.configure(options: options)
    }
}
