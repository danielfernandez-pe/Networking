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
        guard let filePath = Bundle.main.path(forResource: plistPath, ofType: "plist"),
              let options = FirebaseOptions(contentsOfFile: filePath) else {
                  fatalError("We have a problem with Firebase configuration")
              }
        FirebaseApp.configure(options: options)
    }
}
