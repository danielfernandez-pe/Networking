//
//  File.swift
//  
//
//  Created by Daniel Yopla on 23.05.2024.
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
