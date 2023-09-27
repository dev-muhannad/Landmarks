//
//  ContentView.swift
//  Landmarks
//
//  Created by Muhannad on 01/08/2023.
//

import SwiftUI

// This is the root view for the Landmarks app. It connects all of the landmark views in a navigation hierarchy.

struct ContentView: View {
    
    enum Tab {
        case featured
        case list
    }
    
    @State private var selection: Tab = .featured // We chose the Featured tab is a default value.
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)


            LandmarkList()
                .badge(modelData.landmarks.count)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData()) // To add the model object to the environment and make the object available to any subview. A preview fails if any subview requires a model object in the environment, but the view you are previewing doesn’t have the environmentObject(_:) modifier.
    }
}
