//
//  Landmark.swift
//  Landmarks
//
//  Created by Muhannad on 01/08/2023.
//

import Foundation
import SwiftUI
import CoreLocation // Needed to use the CLLocationCoordinate2D type.


struct Landmark: Hashable, Codable, Identifiable {
    // Adding Codable conformance makes it easier to move data between the struct and a data file. You’ll rely on the Decodable component of the Codable protocol later to read data from file.
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
            case lakes = "Lakes"
            case rivers = "Rivers"
            case mountains = "Mountains"
    }
    
    private var imageName: String // To read the name of the image from the data. You make the property private because users of the Landmarks structure care only about the image itself.
    var image: Image {
        Image(imageName) // A computed image property that loads an image from the asset catalog.
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    // Add a coordinates property to the structure using a nested Coordinates type that reflects the storage in the JSON data structure.
    
    private var coordinates: Coordinates // You mark this property as private because you’ll use it only to create a public computed property in the code below.
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    } // A computed property that interacts with the MapKit framework.
        
    
}
