//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Muhannad on 01/08/2023.
//

import SwiftUI

@main
struct LandmarksApp: App { // An app that uses the SwiftUI app life cycle has a structure that conforms to the App protocol. The structure’s body property returns one or more scenes, which in turn provide content for display.
    
    @StateObject private var modelData = ModelData() // Just like @ObservedObject, you never assign a value to an @EnvironmentObject property. Instead, it should be passed in from elsewhere, and ultimately you’re probably going to want to use @StateObject to create it somewhere. However, unlike @ObservedObject we don’t pass our objects into other views by hand. Instead, we use send the data into a modifier called environmentObject() (added below), which makes the object available in SwiftUI’s environment for that view plus any others inside it.
        // and supply it to ContentView using the environmentObject(_:) modifier.
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData) // You apply this modifier so that views further down in the view hierarchy can read data objects passed down through the environment.
        }
    }
}
