//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Muhannad on 02/08/2023.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData // This view now expects to receive a ModelData object in the environment to be able to display its property (landmarks).
    @State private var showFavoriteOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoriteOnly || landmark.isFavorite)
        } // After some thinking, I understand that only one of both statements has to be true. If showFavoriteOnly is false then that results in one true statement so all landmarks can exist. If showFavoriteOnly is ture then this certain condition is false, then move to the other condition and make it true by including in the array only true isFavorite landmarks. In conclusion, all of I have written could be wrong :(
    }
    
    var body: some View {
        NavigationStack {
            List {
                // SwiftUI’s List type can display a platform-specific list of views. The elements of the list can be static, like the child views of the stacks you’ve created so far, or dynamically generated. You can even mix static and dynamically generated views.
                
                // Lists work with identifiable data. You can make your data identifiable in one of two ways: by passing along with your data a key path to a property that uniquely identifies each element, or by making your data type conform to the Identifiable protocol. So in this case, if the struct Landmark doesn't conform to the protocol identifiable, you're going to write this instead: List(landmarks, id: \.id).
                
                Toggle(isOn: $showFavoriteOnly) {
                    Text("Favorites Only")
                }
                ForEach(filteredLandmarks) { landmark in
                    // To combine static and dynamic views in a list, or to combine two or more different groups of dynamic views, use the ForEach type instead of passing your collection of data to List. The ForEach transforms each element in the collection into a child view by using the supplied closure.
                    
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark) // By returning a LandmarkRow from the closure, this creates one LandmarkRow for each element in the landmarks array.
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
        // environmentObject() makes modelData available in SwiftUI’s environment for this view plus any others inside it.
        // Note: Environment objects must be supplied by an ancestor view – if SwiftUI can’t find an environment object of the correct type you’ll get a crash. This applies for previews too, so be careful.
    }
}
