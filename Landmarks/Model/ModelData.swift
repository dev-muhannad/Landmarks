//
//  ModeData.swift
//  Landmarks
//
//  Created by Muhannad on 02/08/2023.
//

import Foundation
import Combine

final class ModelData: ObservableObject { // An observable object is a custom object for your data that can be bound to a view from storage in SwiftUI’s environment. SwiftUI watches for any changes to observable objects that could affect a view, and displays the correct version of the view after a change. An observable object needs to publish any changes to its data, so that its subscribers can pick up the change.

    @Published var landmarks: [Landmark] = load("landmarkData.json") // An array of landmarks that you initialize from landmarkData.json.
    
    var hikes: [Hike] = load("hikeData.json") // Because you’ll never modify hike data after initially loading it, you don’t need to mark it with the @Published attribute.
    @Published var profile = Profile.default // An instance of the user profile that persists even after the user dismisses the profile view.

    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    } // A computed features array, which contains only the landmarks that have isFeatured set to true.
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    } // A computed categories dictionary, with category names as keys, and an array of associated landmarks for each key.
}


// Create a load(_:) method that fetches JSON data with a given name from the app’s main bundle.
func load<T: Decodable>(_ filename: String) -> T {
    // The load method relies on the return type’s conformance to the Decodable protocol, which is one component of the Codable protocol.
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
